# ktweaker

A collection of handy scripts and tasks to optimize your Windows system performance.

## Features

1. **Clear Temporary Files**  
   Clears all files in `%temp%`. Files requiring administrator privileges will be ignored.

2. **Clear Recycle Bin**  
   Empties the Recycle Bin to free up disk space.

3. **Flush DNS Cache**  
   Clears old DNS cache from your ISP. This may result in faster ping and improved network performance.

4. **Update DNS Servers**  
   Sets the IPv4 DNS servers to `1.1.1.1` and `1.0.0.1` (Cloudflare).

5. **Clear Windows Update Cache**  
   Frees up space by deleting cached Windows Update files.

6. **Clear Prefetch Files**  
   Removes prefetch files, which are temporary data stored by Windows for faster program loading but can accumulate as bloat.

7. **Stop Unnecessary Services**  
   Halts high-performance services that might be consuming unnecessary resources. You can find these listed in Task Manager.

8. **Clear Event Logs**  
   Deletes all logs from the Windows Event Viewer.

9. **Scan and Repair System Files**  
   Scans your filesystem for corrupted or missing files and repairs them.  
   *Note: This may take a few minutes and could prompt you to restart afterward.*

---

## How to Use

1. Clone this repository to your local machine:  
   ```bash
   git clone https://github.com/your-username/windows-optimization-toolkit.git
