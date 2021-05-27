# 1.4.1

Ingress: remove gke managed certificate mention

# 1.2.0

.Values.rasa.models_in_gcs - True if models should be stored in gs://{release}-models

# 0.3.0

.Values.endpoints -> .Values.rasa.endpoints
.Values.image -> .Values.{rasa,backend}.image