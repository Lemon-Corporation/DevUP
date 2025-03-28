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
theory_views_counter = metrics.counter(
    'theory_views_total', 'Number of theory views',
    labels={'theory_id': lambda: 'unknown'}
)

theory_completion = metrics.gauge(
    'theory_completion_rate', 'Theory completion rate',
    labels={'difficulty': lambda: 'unknown'}
)

theory_engagement = metrics.histogram(
    'theory_engagement_seconds', 'Time spent on theory',
    labels={'difficulty': lambda: 'unknown'}
)

def generate_random_metrics():
    while True:
        try:
            # Simulate random theory views
            for theory_id in range(1, 4):
                if random.random() < 0.3:  # 30% chance of view
                    # Simply use inc method directly
                    theory_views_counter.labels(theory_id=str(theory_id)).inc(random.randint(1, 5))
            
            # Simulate completion rates
            for difficulty in ['Beginner', 'Intermediate', 'Advanced']:
                theory_completion.labels(difficulty=difficulty).set(random.uniform(0.4, 0.9))
            
            # Simulate engagement time
            for difficulty in ['Beginner', 'Intermediate', 'Advanced']:
                theory_engagement.labels(difficulty=difficulty).observe(random.uniform(30, 300))
        except Exception as e:
            print(f"Error generating metrics: {e}")
        
        time.sleep(5)  # Update every 5 seconds

# Start the metrics generation thread
metrics_thread = Thread(target=generate_random_metrics, daemon=True)
metrics_thread.start()

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "UP"})

@app.route('/', methods=['GET'])
def get_theories():
    # Mock response
    return jsonify({
        "theories": [
            {"id": 1, "title": "Introduction to Python", "difficulty": "Beginner"},
            {"id": 2, "title": "Object-Oriented Programming", "difficulty": "Intermediate"},
            {"id": 3, "title": "Advanced Data Structures", "difficulty": "Advanced"}
        ]
    })

@app.route('/<int:theory_id>', methods=['GET'])
def get_theory(theory_id):
    # Mock response
    theories = {
        1: {"id": 1, "title": "Introduction to Python", "content": "Python is a high-level programming language...", "difficulty": "Beginner"},
        2: {"id": 2, "title": "Object-Oriented Programming", "content": "OOP is a programming paradigm...", "difficulty": "Intermediate"},
        3: {"id": 3, "title": "Advanced Data Structures", "content": "Advanced data structures include trees...", "difficulty": "Advanced"}
    }
    
    if theory_id in theories:
        # Record view metric
        theory_views_counter.labels(theory_id=str(theory_id)).inc()
        return jsonify(theories[theory_id])
    else:
        return jsonify({"error": "Theory not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8004))) 