set -e

# Get PROJECT_ID from .env file
PROJECT_ID=$(grep PROJECT_ID .env | cut -d '=' -f2)

# Check if PROJECT_ID is empty or unset
if [ -z "$PROJECT_ID" ]; then
  echo "PROJECT_ID not found in .env"
  exit 1
fi

# Print PROJECT_ID for confirmation
echo "Using PROJECT_ID: $PROJECT_ID"

# Build the Docker image and tag it with the proper GCR tag
docker build -t gcr.io/$PROJECT_ID/grow .

# Submit the build to Google Cloud Build
gcloud builds submit --tag gcr.io/$PROJECT_ID/grow
gcloud run deploy grow-backend --image gcr.io/$PROJECT_ID/grow --platform managed --region europe-west1 --allow-unauthenticated
