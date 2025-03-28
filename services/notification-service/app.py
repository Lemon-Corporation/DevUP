from flask import Flask, jsonify, request
from prometheus_flask_exporter import PrometheusMetrics
import os
import random
import time
from threading import Thread
from datetime import datetime

app = Flask(__name__)
metrics = PrometheusMetrics(app)

# Static information as metric
metrics.info('app_info', 'Application info', version='1.0.0')

# Custom metrics
notification_count = metrics.counter(
    'notifications_sent_total', 'Number of notifications sent',
    labels={'type': lambda: 'unknown'}
)

notification_delivery_time = metrics.histogram('notification_delivery_seconds', 'Time taken to deliver notifications')

subscription_count = metrics.gauge(
    'subscription_count', 'Number of active subscriptions',
    labels={'type': lambda: 'unknown'}
)

notification_read_rate = metrics.gauge(
    'notification_read_rate', 'Rate of notification reads',
    labels={'type': lambda: 'unknown'}
)

def generate_random_metrics():
    while True:
        try:
            # Simulate notification sending
            for notif_type in ['achievement', 'task', 'reminder', 'promotion']:
                if random.random() < 0.4:  # 40% chance of notification
                    notification_count.labels(type=notif_type).inc(random.randint(1, 10))
            
            # Simulate delivery time
            notification_delivery_time.observe(random.uniform(0.1, 1.0))
            
            # Simulate subscription counts
            for sub_type in ['achievement', 'task', 'reminder', 'promotion']:
                subscription_count.labels(type=sub_type).set(random.randint(100, 1000))
            
            # Simulate read rates
            for notif_type in ['achievement', 'task', 'reminder', 'promotion']:
                notification_read_rate.labels(type=notif_type).set(random.uniform(0.5, 0.9))
        except Exception as e:
            print(f"Error generating metrics: {e}")
        
        time.sleep(5)  # Update every 5 seconds

# Start the metrics generation thread
metrics_thread = Thread(target=generate_random_metrics, daemon=True)
metrics_thread.start()

# Mock database for notifications
notifications_db = {
    1: [
        {"id": 101, "type": "achievement", "title": "Level Up!", "message": "You've reached level 5!", "read": False, "created_at": "2023-06-01T10:30:00Z"},
        {"id": 102, "type": "task", "title": "New Task Available", "message": "Check out the new Python challenges", "read": True, "created_at": "2023-06-02T14:20:00Z"}
    ],
    2: [
        {"id": 201, "type": "reminder", "title": "Daily Challenge", "message": "Don't forget your daily coding challenge!", "read": False, "created_at": "2023-06-03T09:00:00Z"}
    ]
}

# Mock subscription settings
subscriptions = {
    1: {"achievement": True, "task": True, "reminder": False, "promotion": True},
    2: {"achievement": True, "task": False, "reminder": True, "promotion": False}
}

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "UP"})

@app.route('/user/<int:user_id>', methods=['GET'])
def get_notifications(user_id):
    if user_id not in notifications_db:
        return jsonify({"notifications": []}), 200
    
    # Filter by read status if specified
    read_status = request.args.get('read')
    notifications = notifications_db[user_id]
    
    if read_status is not None:
        read_bool = read_status.lower() == 'true'
        notifications = [n for n in notifications if n['read'] == read_bool]
    
    # Update read rate metric
    total = len(notifications_db[user_id])
    read = len([n for n in notifications_db[user_id] if n['read']])
    if total > 0:
        for notif_type in ['achievement', 'task', 'reminder', 'promotion']:
            notification_read_rate.labels(type=notif_type).set(read / total)
    
    return jsonify({"notifications": notifications})

@app.route('/subscribe', methods=['POST'])
def subscribe():
    data = request.json
    if not data or 'userId' not in data or 'type' not in data:
        return jsonify({"error": "Missing required fields"}), 400
    
    user_id = data['userId']
    notif_type = data['type']
    
    if user_id not in subscriptions:
        subscriptions[user_id] = {"achievement": False, "task": False, "reminder": False, "promotion": False}
    
    if notif_type in subscriptions[user_id]:
        subscriptions[user_id][notif_type] = True
        # Update subscription count metric
        count = sum(1 for u in subscriptions for t, v in subscriptions[u].items() if t == notif_type and v)
        subscription_count.labels(type=notif_type).set(count)
        
        return jsonify({"success": True, "message": f"Subscribed to {notif_type} notifications"})
    else:
        return jsonify({"error": f"Invalid notification type: {notif_type}"}), 400

@app.route('/unsubscribe', methods=['DELETE'])
def unsubscribe():
    data = request.json
    if not data or 'userId' not in data or 'type' not in data:
        return jsonify({"error": "Missing required fields"}), 400
    
    user_id = data['userId']
    notif_type = data['type']
    
    if user_id in subscriptions and notif_type in subscriptions[user_id]:
        subscriptions[user_id][notif_type] = False
        # Update subscription count metric
        count = sum(1 for u in subscriptions for t, v in subscriptions[u].items() if t == notif_type and v)
        subscription_count.labels(type=notif_type).set(count)
        
        return jsonify({"success": True, "message": f"Unsubscribed from {notif_type} notifications"})
    else:
        return jsonify({"error": "Invalid user ID or notification type"}), 400

@app.route('/send', methods=['POST'])
def send_notification():
    # This would normally be triggered by Kafka events
    # But for the mock, we'll make it a direct API call
    data = request.json
    if not data or 'userId' not in data or 'type' not in data or 'title' not in data or 'message' not in data:
        return jsonify({"error": "Missing required fields"}), 400
    
    user_id = data['userId']
    notif_type = data['type']
    
    # Check if user is subscribed to this notification type
    if user_id in subscriptions and subscriptions[user_id].get(notif_type, False):
        if user_id not in notifications_db:
            notifications_db[user_id] = []
        
        new_id = random.randint(1000, 9999)
        notification = {
            "id": new_id,
            "type": notif_type,
            "title": data['title'],
            "message": data['message'],
            "read": False,
            "created_at": datetime.now().strftime("%Y-%m-%dT%H:%M:%SZ")
        }
        
        notifications_db[user_id].append(notification)
        
        # Update notification count metric
        notification_count.labels(type=notif_type).inc()
        # Record delivery time
        delivery_time = random.uniform(0.05, 0.5)
        notification_delivery_time.observe(delivery_time)
        
        return jsonify({"success": True, "notificationId": new_id})
    else:
        return jsonify({"success": False, "message": "User not subscribed to this notification type"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8007))) 