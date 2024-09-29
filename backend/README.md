## Backend

This is the backend service for the app.
It can be run locally with docker via 
```bash
./deploy-run-local.sh
```
Which should deploy the docker image and bind it to port 80 on localhost.

From there `https://0.0.0.0:80/docs` can be visited to view the data models

Alternatively, it can be deployed to google cloud from a machine with properly set up and authorized google-cli via
```bash
./deploy_gcloud.sh
```
Please note that it first requires to set up a `.env` file with the content:
```
PROJECT_ID={YOUR_PROJET_ID}
```