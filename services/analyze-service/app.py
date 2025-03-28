from flask import Flask, jsonify, request
from prometheus_flask_exporter import PrometheusMetrics
import os
import random
import time
from threading import Thread
from datetime import datetime, timedelta

app = Flask(__name__)
metrics = PrometheusMetrics(app)

# Static information as metric
metrics.info('app_info', 'Application info', version='1.0.0')

# Custom metrics
active_users = metrics.gauge(
    'active_users', 'Number of active users',
    labels={'period': lambda: 'unknown'}
)

user_retention = metrics.gauge(
    'user_retention_rate', 'User retention rate',
    labels={'period': lambda: 'unknown'}
)

task_completion = metrics.gauge(
    'task_completion_rate', 'Task completion rate',
    labels={'difficulty': lambda: 'unknown'}
)

learning_time = metrics.histogram(
    'learning_time_minutes', 'Time spent learning',
    labels={'topic': lambda: 'unknown'}
)

revenue = metrics.counter(
    'revenue_total', 'Total revenue',
    labels={'source': lambda: 'unknown'}
)

def generate_random_metrics():
    while True:
        try:
            # Simulate active users
            for period in ['daily', 'weekly', 'monthly']:
                if period == 'daily':
                    active_users.labels(period=period).set(random.randint(1000, 5000))
                elif period == 'weekly':
                    active_users.labels(period=period).set(random.randint(5000, 20000))
                else:
                    active_users.labels(period=period).set(random.randint(20000, 50000))
            
            # Simulate user retention
            for period in ['day1', 'day7', 'day30']:
                user_retention.labels(period=period).set(random.uniform(0.1, 0.8))
            
            # Simulate task completion rates
            for difficulty in ['easy', 'medium', 'hard']:
                task_completion.labels(difficulty=difficulty).set(random.uniform(0.4, 0.9))
            
            # Simulate learning time
            for topic in ['algorithms', 'data_structures', 'web_dev', 'mobile_dev']:
                learning_time.labels(topic=topic).observe(random.uniform(10, 120))
            
            # Simulate revenue
            for source in ['subscription', 'ads', 'premium']:
                if random.random() < 0.3:  # 30% chance of revenue
                    revenue.labels(source=source).inc(random.randint(10, 100))
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
def get_analytics_overview():
    # Mock analytics data
    daily_users = random.randint(1000, 5000)
    active_users.labels(period='daily').set(daily_users)
    
    return jsonify({
        "active_users": {
            "daily": daily_users,
            "weekly": random.randint(5000, 20000),
            "monthly": random.randint(20000, 50000)
        },
        "user_retention": {
            "day1": random.uniform(0.5, 0.8),
            "day7": random.uniform(0.3, 0.6),
            "day30": random.uniform(0.1, 0.4)
        },
        "task_completion_rate": random.uniform(0.4, 0.9)
    })

@app.route('/user/<int:user_id>/stats', methods=['GET'])
def get_user_stats(user_id):
    # Mock user statistics
    learning_minutes = random.randint(10, 200)
    topic = random.choice(['algorithms', 'data_structures', 'web_dev', 'mobile_dev'])
    learning_time.labels(topic=topic).observe(learning_minutes)
    
    return jsonify({
        "userId": user_id,
        "tasksCompleted": random.randint(10, 100),
        "averageScore": random.uniform(65, 95),
        "learningTime": learning_minutes,
        "streak": random.randint(0, 30),
        "strongestTopic": random.choice(["Algorithms", "Data Structures", "Web Development", "Databases"]),
        "weakestTopic": random.choice(["Security", "Machine Learning", "Testing", "Mobile Development"])
    })

@app.route('/reports/time-series', methods=['GET'])
def get_time_series():
    # Generate mock time series data for the last 30 days
    today = datetime.now()
    data = []
    
    for i in range(30):
        day = today - timedelta(days=i)
        revenue_amount = round(random.uniform(1000, 5000), 2)
        source = random.choice(['subscription', 'ads', 'premium'])
        revenue.labels(source=source).inc(int(revenue_amount/10))
        
        data.append({
            "date": day.strftime('%Y-%m-%d'),
            "activeUsers": random.randint(1000, 5000),
            "newUsers": random.randint(100, 1000),
            "taskCompletions": random.randint(5000, 15000),
            "revenue": revenue_amount
        })
    
    return jsonify({"data": data})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8006))) 