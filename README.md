**REST API Test Automation with Robot Framework and FastAPI**

This project contains two tasks: testing a public REST API using Robot Framework and building a small device REST API using FastAPI.

Technologies: Python 3.11+, Robot Framework, RequestsLibrary, FastAPI, Uvicorn and uv.

1. Project Structure:
   
  <img width="600" height="243" alt="image" src="https://github.com/user-attachments/assets/75bcda07-d08d-4024-a42b-2d141d3e9de7" />

2. Setup on a Clean Linux Machine
   
 Prerequisites
         Linux (Ubuntu or WSL2)
         Git and an internet connection
         Python 3.11 or newer
         uv package manager

  Install uv if it is not available:
  
         curl -LsSf https://astral.sh/uv/install.sh | sh

  Restart the terminal and check the installation:

          uv --version

  Get the Project Ready

  Extract the submitted project ZIP and navigate to the directory containing pyproject.toml.

  Install the dependencies:

          uv sync --locked

This creates a virtual environment and installs Robot Framework, RequestsLibrary, FastAPI and Uvicorn.

Verify Robot Framework:

         uv run robot --version

The project is now ready to run.

3. Task 1 — Public REST API Testing
   
  Objective: Validate the public API at https://jsonplaceholder.typicode.com/users.

  <img width="562" height="190" alt="image" src="https://github.com/user-attachments/assets/6b1d5bbf-ee44-42d8-ad23-e225c69520cc" />

  Run the tests from the project directory:

          uv run robot --outputdir results tests/users.robot

  The API base URL is defined as ${BASE_URL} in the Robot suite and can be changed without modifying the test file:

          uv run robot --variable BASE_URL:https://jsonplaceholder.typicode.com --outputdir results tests/users.robot

  No local server is needed for Task 1.

4. Task 2 — Device REST API with FastAPI

   Objective: Build a small device inventory API and test its responses using Robot Framework.

   The application contains two predefined devices:

   <img width="204" height="113" alt="image" src="https://github.com/user-attachments/assets/0d23daa4-630b-4d6e-b1f5-7cf302fa111e" />
   
   API Endpoints:
   
   <img width="499" height="150" alt="image" src="https://github.com/user-attachments/assets/98348184-f88b-453e-9645-f260151fc7d4" />

   Start the API Server

   Open Terminal 1 in the project directory:

          uv run uvicorn app:app --reload

   The server runs by default at http://127.0.0.1:8000.

   Interactive API documentation is available at http://127.0.0.1:8000/docs.

   Run the Device Tests

   Keep the server running and open Terminal 2 in the same directory:

         uv run robot --outputdir results tests/devices.robot

   The suite performs three checks:

     T2-01: HTTP 200 and exactly two devices.

     T2-02: HTTP 200 and PART1234 has status ACTIVE.

     T2-03: HTTP 404 with detail "Device not found" for an unknown device.

5. Run Both Tasks Together

   With the FastAPI server running, execute:

         uv run robot --outputdir results tests/

   This runs all seven tests from both suites.
   
6. Robot Framework Result Files

   After execution, Robot Framework creates three files inside the results/ directory.

   File and it's Purpose:

      report.html: Shows the overall test summary, pass/fail counts and statistics.

      log.html: Shows detailed test execution, keywords and failure messages.

      output.xml: Stores machine-readable results for reporting and CI/CD integration.
   
   How to Investigate a Failed Test

      Check the terminal output to identify the failed test.

      Open results/report.html to review the summary.

      Open results/log.html and inspect the failed test and its keywords.

      Compare the expected and actual values to identify the problem.

      Fix the issue and rerun the test.

      For Task 2, also check that the FastAPI server is running.

7. Implementation Notes

      Both suites use Robot Framework and RequestsLibrary.

      Each required check is implemented as a separate test case.

      Task 1 uses a configurable API base URL.

      Task 2 uses an in-memory device list; no database is required.

      Dependencies are managed using uv and pyproject.toml.

      The .venv/ directory and generated test reports are excluded from Git.

      Git commits record the setup, tests, API implementation and documentation in separate steps.

The solution is kept simple and focused on the assignment requirements, with readable tests and minimal setup.





   

