#!/bin/bash
set -e

# Define your Docker Hub username here.
DOCKER_USERNAME="vignesh8386"

# List of microservices to build and push
MICROSERVICES=(
    "admin-service"
    "api-gateway"
    "authentication-service"
    "cart-service"
    "frontend-ui"
    "inventory-service"
    "invoice-service"
    "order-service"
    "payment-service"
    "product-service"
    "recommendation-service"
    "review-rating-service"
    "search-service"
    "shipping-service"
    "user-service"
    "wishlist-service"
)

echo "Starting Docker Build and Push Process..."
echo "Target Docker Registry Namespace: $DOCKER_USERNAME"
echo "Make sure you are logged into Docker Hub (run 'docker login' if you haven't already)."
sleep 2

for SERVICE in "${MICROSERVICES[@]}"; do
    IMAGE_NAME="$DOCKER_USERNAME/$SERVICE:latest"
    
    if [ -d "$SERVICE" ]; then
        echo -e "\n======================================================="
        echo "Building $IMAGE_NAME from directory $SERVICE..."
        
        docker build -t "$IMAGE_NAME" "$SERVICE"
        
        if [ $? -eq 0 ]; then
            echo "Successfully built $IMAGE_NAME. Pushing to Docker Hub..."
            docker push "$IMAGE_NAME"
            
            if [ $? -eq 0 ]; then
                echo "Successfully pushed $IMAGE_NAME!"
            else
                echo "Failed to push $IMAGE_NAME. Exiting."
                exit 1
            fi
        else
            echo "Failed to build $IMAGE_NAME. Exiting."
            exit 1
        fi
    else
        echo "Directory $SERVICE does not exist. Skipping."
    fi
done

echo -e "\n======================================================="
echo "All 16 microservices have been successfully built and pushed!"
