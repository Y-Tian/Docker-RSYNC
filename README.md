# Rsync

This script serves to watch two directories the User indicates: <$DIR1> and <$DIR2>
When those two directories are modified, a Rsync is performed to symlink that directory to the target directory.

The example given here works well with SFTP file communications. AKA: https://filezilla-project.org/

## Getting Started

Remove the tags <$DIR1>, <$DIR2>, and <$DIR3>. Replace them with your own respective directories.

## Running the tests

1. SFTP into a specific User using FileZilla.
2. Run in the background
```
./rsync.sh
```
3. Drop files into monitored directories and watch for the same file to be symlinked into the target directory.

### Debugging

- Check logs for system events -> will output the results of the rsync and inotify results. Debug from there.

## Additions

- Included a sample Dockerfile for testing purposes. The Dockerfile, once built into an image, will copy the rsync script and run it on startup. The image will serve as a testing environment.

