# Guide: Deploying and Running Tests on Kubernetes with SparkTest

This guide explains how to package your tests into Docker images and run them on a Kubernetes cluster using the SparkTest application.

## Core Concepts

SparkTest runs your tests as **Kubernetes Jobs**. Here’s a breakdown of the key concepts:

-   **Test Code**: Your actual test scripts, binaries, or code that you want to execute.
-   **Test Image**: A Docker image containing your test code and all necessary dependencies. This image must be stored in a container registry accessible by your Kubernetes cluster.
-   **Test Definition**: A configuration in the SparkTest UI that specifies the Test Image and the command to execute inside it.
-   **Test Run**: An instance of a Test Definition being executed in Kubernetes, which you can monitor and view logs for in the SparkTest UI.

## Prerequisites

1.  **Running Kubernetes Cluster**: You need access to a Kubernetes cluster. For local development, we recommend using [k3d](https://k3d.io/) as described in `backend/KUBERNETES.md`.
2.  **`kubectl` Access**: Your `kubectl` command-line tool must be configured to communicate with your cluster. SparkTest uses your local kubeconfig file (`~/.kube/config`) to connect.
3.  **Running SparkTest Instance**: The SparkTest application (both frontend and backend) must be running and accessible.
4.  **Container Registry**: You need a place to push your Test Images, such as Docker Hub, Google Container Registry (GCR), or a private registry. Your Kubernetes cluster must have permission to pull images from this registry.

---

## Step 1: Package Your Test into a Docker Image

Your test suite must be containerized. This involves creating a `Dockerfile` that bundles your test code and its dependencies.

**Example `Dockerfile` for a Python test:**

Let's say you have a Python script `tests/test_api.py` that uses `pytest` and `requests`.

```dockerfile
# Dockerfile

# 1. Start with a base image that has your required language/runtime
FROM python:3.9-slim

# 2. Set a working directory
WORKDIR /app

# 3. Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy your test code into the image
COPY ./tests /app/tests

# 5. The image is now ready. The command to run the tests will be specified
#    later in the SparkTest UI.
```

**Build and Push the Image:**

```bash
# Build the Docker image
docker build -t your-registry/your-repo:my-test-v1 .

# Push the image to your container registry
docker push your-registry/your-repo:my-test-v1
```

---

## Step 2: Create a Test Definition in SparkTest

Now, open the SparkTest web UI and configure the test you just pushed.

1.  Navigate to the **Definitions** or **New Test** page.
2.  Fill out the "Create Test Definition" form:
    *   **Name**: A descriptive name for your test (e.g., "API Health Check").
    *   **Image**: The full path to the Docker image you pushed in Step 1.
        -   `your-registry/your-repo:my-test-v1`
    *   **Command**: The command to execute inside the container to run your tests. This is an array of strings in JSON format.
        -   For our Python example, this would be: `["pytest", "tests/test_api.py"]`
    *   **Description**: An optional description for your test.

3.  Click **Save**.

Your Test Definition is now ready to be run.

---

## Step 3: Run the Test and View Logs

1.  From the list of Test Definitions, find the one you just created.
2.  Click the **Run** button.
3.  You will be redirected to the **Test Runs** page, where you can see your test appear with a "running" status.
4.  Click on the test run to view its details. The UI will display the live logs being streamed directly from the Kubernetes pod running your test.

SparkTest automatically creates a Kubernetes Job in the `default` namespace. The job name will be `test-run-<uuid>`.

---

## Troubleshooting

If your test run fails or gets stuck in a "pending" state, you can use `kubectl` to debug.

1.  **Find the Pod**: First, find the pod associated with your test run. The pod name is visible in the Test Run details page in the UI. You can also find it via labels:

    ```bash
    # The job name is based on the run ID from the UI/database
    kubectl get pods -l app=sparktest,component=test-runner
    ```

2.  **Check Pod Status**: Use `kubectl describe` to see why a pod might be pending or failing.

    ```bash
    kubectl describe pod <your-pod-name>
    ```

    Common issues include:
    *   `ImagePullBackOff`: The cluster cannot pull your Test Image. Check that the image path is correct and that the cluster has the necessary credentials.
    *   `CrashLoopBackOff`: The container starts but exits with an error immediately. Check the logs.
    *   `Pending`: The cluster may not have enough resources (CPU, memory) to schedule your pod.

3.  **View Logs Manually**: You can also fetch logs directly with `kubectl`.

    ```bash
    kubectl logs <your-pod-name>
    ```

This covers the end-to-end process of running your custom tests on Kubernetes through the SparkTest platform.
