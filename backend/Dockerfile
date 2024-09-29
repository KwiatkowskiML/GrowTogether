FROM python:3.12-slim AS base

################################################################################
#                                    server                                    #
################################################################################

#------------------------------------------------------------------------------#
#                               Dependency Stage                               #
#------------------------------------------------------------------------------#

FROM base AS dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade -r requirements.txt

#------------------------------------------------------------------------------#
#                                Runtime Stage                                 #
#------------------------------------------------------------------------------#

FROM dependencies AS runtime
WORKDIR /app
EXPOSE 8080
COPY . .

# Use the PORT environment variable set by Cloud Run
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
