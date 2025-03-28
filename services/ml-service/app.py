from flask import Flask, jsonify, request
from prometheus_flask_exporter import PrometheusMetrics
import os
import random
import time
from threading import Thread

app = Flask(__name__)
metrics = PrometheusMetrics(app)

# Static information as metric
metrics.info('app_info', 'Application info', version='1.0.0')

# Custom metrics
code_analysis_time = metrics.histogram('code_analysis_duration_seconds', 'Time taken for code analysis')

analysis_accuracy = metrics.gauge(
    'code_analysis_accuracy', 'Accuracy of code analysis', 
    labels={'type': lambda: 'unknown'}
)

model_performance = metrics.gauge(
    'model_performance', 'ML model performance metrics', 
    labels={'metric': lambda: 'unknown'}
)

recommendation_quality = metrics.gauge(
    'recommendation_quality', 'Quality of task recommendations', 
    labels={'user_level': lambda: 'unknown'}
)

def generate_random_metrics():
    while True:
        try:
            # Simulate code analysis time
            code_analysis_time.observe(random.uniform(0.1, 2.0))
            
            # Simulate analysis accuracy
            for analysis_type in ['complexity', 'efficiency', 'style']:
                analysis_accuracy.labels(type=analysis_type).set(random.uniform(0.7, 0.95))
            
            # Simulate model performance
            for metric in ['precision', 'recall', 'f1_score']:
                model_performance.labels(metric=metric).set(random.uniform(0.8, 0.98))
            
            # Simulate recommendation quality
            for user_level in ['beginner', 'intermediate', 'advanced']:
                recommendation_quality.labels(user_level=user_level).set(random.uniform(0.6, 0.9))
        except Exception as e:
            print(f"Error generating metrics: {e}")
        
        time.sleep(5)  # Update every 5 seconds

# Start the metrics generation thread
metrics_thread = Thread(target=generate_random_metrics, daemon=True)
metrics_thread.start()

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "UP"})

@app.route('/alg-analysis', methods=['POST'])
def analyze_algorithm():
    # Mock algorithm analysis
    # In a real scenario, this would analyze user-submitted code
    data = request.json
    if not data or 'code' not in data:
        return jsonify({"error": "No code provided"}), 400
    
    complexity = random.choice(["O(1)", "O(n)", "O(n log n)", "O(n²)"])
    score = random.randint(60, 100)
    
    # Record metric
    code_analysis_time.observe(random.uniform(0.1, 1.5))
    
    return jsonify({
        "complexity": complexity,
        "score": score,
        "efficiency": "Good" if score > 80 else "Average",
        "suggestions": [
            "Consider using a more efficient data structure",
            "Try to reduce nested loops",
            "Look for redundant computations"
        ]
    })

@app.route('/task-recommendation', methods=['POST'])
def recommend_task():
    # Mock task recommendation
    data = request.json
    if not data or 'userId' not in data:
        return jsonify({"error": "User ID not provided"}), 400
    
    user_level = random.choice(['beginner', 'intermediate', 'advanced'])
    quality = random.uniform(0.6, 0.95)
    recommendation_quality.labels(user_level=user_level).set(quality)
    
    recommended_tasks = [
        {"id": 101, "title": "Array Manipulation", "difficulty": "Easy", "score": 0.95},
        {"id": 203, "title": "Graph Traversal", "difficulty": "Medium", "score": 0.87},
        {"id": 305, "title": "Dynamic Programming Challenge", "difficulty": "Hard", "score": 0.82}
    ]
    
    return jsonify({
        "userId": data.get('userId'),
        "recommendations": recommended_tasks
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8005))) 