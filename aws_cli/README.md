# AWS CLI

Notes for AWS CLI

## S3

I will use keys, folders and directories interchangably. Technically, the "directories" in AWS are keys and they just
give the file a unique name. However, they act a lot like directories.

### Wildcard Search

For some reason this isn't just included, so here is an easy(ish) work around. Copy all files recursively, ignore all
them except the ones that you want and do it in "dryrun" mode so that it doesn't actually do anything.
 

```bash
    # Fake move
    aws s3 mv --dryrun --recursive --exclude '*' --include '*.csv' s3://buck_name/key1/key2/ .

    # Real move
    aws s3 mv --recursive --exclude '*' --include '*.csv' s3://buck_name/key1/key2/ .

    # Works with copy as well.
```
