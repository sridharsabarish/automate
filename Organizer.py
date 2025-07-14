import sys
import subprocess
from loguru  import logger

class Organizer:
    
    def handle_delete_older_than_7_days(self):
        logger.trace("Inside Handle_delete")
        sys.stdout.flush()
        try:
            subprocess.call(["./scripts/deleteDownloads.sh"])
        except FileNotFoundError:
            logger.error("deleteDownloads.sh not found. Please check if the script is in the same directory")
    def handle_pending_diff(self):
        logger.trace("Inside Handle_pending_diff")
        sys.stdout.flush()
        try:
            subprocess.call(["./scripts/MentionPendingGitDiff.sh"])
        except FileNotFoundError:
            logger.error("MentionPendingGitDiff.sh not found. Please check if the script is in the same directory")
def main():
    organizer = Organizer()
    organizer.handle_delete_older_than_7_days()
    organizer.handle_pending_diff()

if __name__ == "__main__":
    main()
