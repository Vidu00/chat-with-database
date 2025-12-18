# 🤖 AI-Powered SQL Chat Application - Docker Deployment Guide

A conversational AI application that allows users to interact with MySQL databases using natural language. This guide will help you run the application using Docker on any machine.

## 📋 Prerequisites

Before running this application, ensure you have:

1. **Docker Desktop** installed and running
   - Download from: https://www.docker.com/products/docker-desktop/
   - Windows: Requires Windows 10/11 Pro, Enterprise, or Education (64-bit)
   - Mac: macOS 10.15 or newer
   - Linux: Docker Engine and Docker Compose

2. **Groq API Key** (free)
   - Sign up at: https://console.groq.com/
   - Navigate to API Keys section
   - Create a new API key
   - Copy the key (starts with `gsk_...`)

## 📁 Project Structure

Ensure your project folder contains these files:

```
project-folder/
├── app.py                  # Main Streamlit application
├── .env                    # Environment variables (you'll create this)
├── BankingDB.sql          # Banking database schema
├── Chinook.sql            # Music store database schema
├── requirements.txt       # Python dependencies
├── Dockerfile            # Docker image configuration
├── docker-compose.yml    # Multi-container orchestration
├── .dockerignore        # Docker ignore rules
└── README.md            # This file
```

## 🚀 Setup Instructions

### Step 1: Create the `.env` File

In the project root directory, create a file named `.env` and add your Groq API key:

```env
GROQ_API_KEY=your_groq_api_key_here
```

Replace `your_groq_api_key_here` with your actual Groq API key.

**Important Notes:**
- The file must be named exactly `.env` (including the dot at the beginning)
- No spaces around the `=` sign
- Keep this file secure and never commit it to version control

### Step 2: Stop Local MySQL (Windows only)

If you have MySQL installed locally on Windows, stop it to avoid port conflicts:

Open Command Prompt as Administrator and run:
```bash
net stop MySQL80
```

Or for older versions:
```bash
net stop MySQL57
```

You can skip this step if you don't have MySQL installed locally.

### Step 3: Verify Docker is Running

Make sure Docker Desktop is running. You should see the Docker whale icon in your system tray.

On Linux, verify with:
```bash
docker --version
docker-compose --version
```

## 🐳 Running the Application

### Option 1: Quick Start (Recommended)

Open a terminal/command prompt in the project directory and run:

```bash
docker-compose up --build
```

This single command will:
- Build the Streamlit application image
- Download the MySQL 8.0 image
- Create and start both containers
- Initialize the databases with sample data
- Set up networking between containers

**Wait 30-60 seconds** for initialization. You'll see output like:

```
You can now view your Streamlit app in your browser.

Local URL: http://localhost:8501
```

### Option 2: Run in Background (Detached Mode)

To run containers in the background:

```bash
docker-compose up -d --build
```

Check container status:
```bash
docker ps
```

You should see two containers running:
- `banking_mysql` (MySQL database)
- `banking_streamlit_app` (Streamlit web app)

## 🌐 Accessing the Application

Once the containers are running, open your web browser and navigate to:

```
http://localhost:8501
```

You should see the Streamlit chat interface.

## 💬 Using the Application

### Connecting to a Database

1. In the sidebar on the left, you'll see connection settings
2. Enter the following credentials:
   - **Host**: `mysql`
   - **Port**: `3306`
   - **User**: `root`
   - **Password**: `admin`
   - **Database**: `BankingDB` or `Chinook`
3. Click the **Connect** button
4. Wait for the success message

### Available Databases

**BankingDB** - A banking system database with:
- 10 customers
- 14 accounts (Checking, Savings, Credit, Investment)
- 15+ transactions
- 10 loans
- 5 branches
- 10 employees
- 10 cards

**Chinook** - A music store database with:
- 20 artists
- 20 albums
- Multiple tracks
- 5 customers
- Sales invoices
- Employees
- Playlists

### Asking Questions

Simply type your questions in natural language in the chat box. Examples:

**For BankingDB:**
```
Show me all customers with their total account balances
What is the total outstanding loan amount?
List all transactions from November 2024
Which branch has the most employees?
Show me customers who have both checking and savings accounts
```

**For Chinook:**
```
Which artists have the most albums?
Show me the top 10 best-selling tracks
List all customers from Brazil
What are the most popular music genres?
Show me total sales by country
```

## 🛠️ Docker Commands Reference

### Starting and Stopping

```bash
# Start containers (first time or after code changes)
docker-compose up --build

# Start containers (subsequent runs)
docker-compose up

# Start in background
docker-compose up -d

# Stop containers (preserves data)
docker-compose down

# Stop and remove all data
docker-compose down -v
```

### Viewing Logs

```bash
# View all logs
docker-compose logs

# View logs for specific service
docker-compose logs streamlit
docker-compose logs mysql

# Follow logs in real-time
docker-compose logs -f

# View last 50 lines
docker-compose logs --tail=50
```

### Container Management

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Restart containers
docker-compose restart

# Execute command inside container
docker exec -it banking_streamlit_app bash
docker exec -it banking_mysql bash
```

### Checking Database

To verify databases were created successfully:

```bash
docker exec -it banking_mysql mysql -uroot -padmin -e "SHOW DATABASES;"
```

Expected output:
```
+--------------------+
| Database           |
+--------------------+
| BankingDB          |
| Chinook            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```

## 🔧 Troubleshooting

### Issue: "empty compose file"

**Cause**: Docker cannot find `docker-compose.yml`

**Solution**: 
- Verify the file exists in the current directory
- Check the filename is exactly `docker-compose.yml` (not `docker-compose.yml.txt`)
- Run command from the correct directory

### Issue: "ports are not available: port 3306"

**Cause**: Local MySQL is using port 3306

**Solution (Windows)**:
```bash
net stop MySQL80
```

**Solution (Alternative)**: Change the port in `docker-compose.yml`:
```yaml
ports:
  - "3307:3306"  # Changed from 3306:3306
```

### Issue: "ports are not available: port 8501"

**Cause**: Another Streamlit instance is running

**Solution**:
```bash
# Find process using port 8501
netstat -ano | findstr :8501

# Kill the process (replace PID with actual number)
taskkill /PID <PID> /F

# Or restart Docker
docker-compose down
docker-compose up --build
```

### Issue: Blank page in browser

**Solutions to try**:

1. **Clear browser cache**: Press `Ctrl + Shift + Delete`

2. **Hard refresh**: Press `Ctrl + F5`

3. **Try incognito mode**: Press `Ctrl + Shift + N`

4. **Check if app is running**:
```bash
docker-compose logs streamlit
```

5. **Verify health endpoint**: Open `http://localhost:8501/_stcore/health`

6. **Rebuild containers**:
```bash
docker-compose down -v
docker-compose up --build
```

### Issue: "Failed to connect to database"

**Cause**: MySQL container not fully initialized

**Solution**: 
- Wait 30-60 seconds after starting containers
- Check MySQL logs: `docker-compose logs mysql`
- Verify credentials (root/admin)

### Issue: API key error

**Error**: `The api_key client option must be set`

**Solution**:
- Verify `.env` file exists in project root
- Check the file contains: `GROQ_API_KEY=your_actual_key`
- Restart containers: `docker-compose restart`
- Rebuild if needed: `docker-compose up --build`

### Issue: Containers keep restarting

**Diagnosis**:
```bash
docker-compose logs --tail=100
```

**Common causes**:
- Missing `.env` file
- Invalid API key
- Port conflicts
- Insufficient system resources

**Solution**: Check logs for specific error and apply relevant fix above

## 🔄 Rebuilding After Changes

If you modify `app.py` or other source files:

```bash
# Stop containers
docker-compose down

# Rebuild and restart
docker-compose up --build
```

## 🧹 Cleanup

To completely remove all containers, images, and data:

```bash
# Remove containers and volumes
docker-compose down -v

# Remove images (optional)
docker rmi banking_streamlit_app
docker rmi mysql:8.0

# Remove all unused Docker resources (careful!)
docker system prune -a
```

## 📊 System Requirements

**Minimum**:
- 4 GB RAM
- 2 CPU cores
- 5 GB free disk space

**Recommended**:
- 8 GB RAM
- 4 CPU cores
- 10 GB free disk space

## 🔐 Security Notes

- Default credentials (root/admin) are for development only
- In production, use strong passwords and environment variables
- Never commit `.env` file to version control
- Consider using Docker secrets for sensitive data
- Implement network security policies for production deployments

## 🎯 Quick Reference

**One-line deployment**:
```bash
docker-compose up --build
```

**Check if running**:
```bash
docker ps
```

**View app**:
```
http://localhost:8501
```

**Stop everything**:
```bash
docker-compose down
```

## 💡 Tips for Demonstration

1. **Pre-start containers** before the demo to save time
2. **Test connection** to both databases beforehand
3. **Prepare sample questions** for each database
4. **Have logs visible** in a separate terminal window
5. **Show Docker commands** to demonstrate containerization

## 📞 Support

If you encounter issues not covered in this guide:

1. Check container logs: `docker-compose logs`
2. Verify all files are present and correctly named
3. Ensure Docker Desktop is running
4. Check system has sufficient resources
5. Try a complete rebuild: `docker-compose down -v && docker-compose up --build`

## 🛠️ Technologies Used

- **Streamlit**: Web application framework
- **LangChain**: AI orchestration
- **Groq**: LLama 3.3 70B language model
- **MySQL**: Relational database
- **Docker**: Containerization platform
- **Docker Compose**: Multi-container orchestration

---

**Ready to Run**: Follow the steps above and you'll have the application running in minutes!