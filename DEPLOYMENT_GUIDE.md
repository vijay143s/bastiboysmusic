# GitHub Actions Deployment to cPanel

This guide will help you set up automatic deployment to your cPanel hosting account using GitHub Actions.

## Prerequisites

1. A cPanel hosting account
2. FTP access to your cPanel account
3. SSH access to your cPanel account (optional, for running commands)
4. GitHub repository with your code

## Setup Instructions

### Step 1: Get Your cPanel Credentials

1. **FTP Credentials:**
   - Log in to your cPanel account
   - Go to "FTP Accounts" or "File Manager"
   - Note down:
     - FTP Server (usually your domain or server IP)
     - FTP Username
     - FTP Password
     - Deployment directory (usually `public_html` or a subdirectory)

2. **SSH Credentials (Optional but recommended):**
   - In cPanel, go to "SSH Access"
   - Enable SSH if not already enabled
   - Note down:
     - SSH Host (same as FTP server)
     - SSH Username (usually same as cPanel username)
     - SSH Port (usually 21098 or 22)
     - SSH Password (same as cPanel password)

### Step 2: Add Secrets to GitHub Repository

1. Go to your GitHub repository
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret** and add the following secrets:

   **Required Secrets:**
   - `FTP_SERVER`: Your cPanel FTP server (e.g., `ftp.yourdomain.com` or server IP)
   - `FTP_USERNAME`: Your FTP username
   - `FTP_PASSWORD`: Your FTP password

   **Optional Secrets (for SSH deployment):**
   - `SSH_HOST`: Your cPanel SSH host (usually same as FTP server)
   - `SSH_USERNAME`: Your SSH username
   - `SSH_PASSWORD`: Your SSH password
   - `SSH_PORT`: SSH port (usually `21098` for cPanel shared hosting)

### Step 3: Configure the Workflow

Edit `.github/workflows/deploy.yml` and customize:

1. **Branch name** (line 5): Change `main` to your production branch name
2. **Server directory** (line 47): Change `./public_html/` to your deployment path
3. **Exclude patterns** (lines 48-53): Add any files/folders you don't want to deploy
4. **Remote commands** (line 62): Customize commands to start/restart your app

### Step 4: Prepare Your cPanel Server

1. **Install Node.js** (if not already installed):
   - In cPanel, go to "Setup Node.js App" or "Application Manager"
   - Create a new Node.js application
   - Set the application root to your deployment directory
   - Set the application startup file to `backend/index.js`

2. **Install PM2** (for process management):
   ```bash
   npm install -g pm2
   ```

3. **Create `.env` file** on the server:
   - Upload or create your `.env` file with production settings
   - Make sure it contains all necessary environment variables

### Step 5: Deploy

1. Push your code to the configured branch (e.g., `main`)
2. GitHub Actions will automatically:
   - Install dependencies
   - Build the frontend
   - Deploy files to your cPanel server
   - Restart the application (if SSH is configured)

3. Monitor the deployment:
   - Go to your repository → **Actions** tab
   - Click on the running workflow to see logs

## Manual Deployment

You can also trigger deployment manually:
1. Go to your repository → **Actions** tab
2. Select "Build and Deploy to cPanel" workflow
3. Click "Run workflow"

## Troubleshooting

### FTP Connection Issues
- Verify FTP credentials in GitHub Secrets
- Check if FTP port is open (usually 21)
- Some cPanel hosts require passive mode

### SSH Connection Issues
- Verify SSH is enabled in cPanel
- Check SSH port (usually 21098 for shared hosting)
- Verify SSH credentials

### Application Not Starting
- Check PM2 logs: `pm2 logs bastiboysmusic`
- Verify Node.js version compatibility
- Check `.env` file exists and has correct values

### Build Failures
- Check the Actions tab for error logs
- Verify dependencies are listed in `package.json`
- Ensure build scripts are correct

## Alternative: FTP-Only Deployment

If SSH is not available, remove the "Execute remote commands" step from the workflow and:
1. Set up a cPanel cron job to check for updates
2. Or manually restart the app through cPanel's Node.js manager after deployment

## Directory Structure on cPanel

After deployment, your cPanel directory should look like:
```
public_html/
├── backend/
│   ├── index.js
│   ├── controllers/
│   ├── models/
│   └── ...
├── frontend/
│   └── dist/
│       ├── index.html
│       ├── assets/
│       └── ...
├── node_modules/
├── package.json
└── .env (manually created)
```

## Security Notes

1. **Never commit secrets** to your repository
2. **Use strong passwords** for FTP/SSH
3. **Restrict GitHub Actions** to specific branches
4. **Review deployment logs** regularly
5. **Keep `.env` file** out of version control

## Support

If you encounter issues:
1. Check GitHub Actions logs for error messages
2. Verify all secrets are correctly set
3. Contact your hosting provider for cPanel-specific issues
4. Check cPanel error logs in "Error Log" section
