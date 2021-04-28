# Update Remote Status Action

This action uses a partial Github Token (with statuses scope enabled) to update the build status of a private remote repository. When having a private fork from a private repository, you can use this action to update the build status for pull requests and pushes from the Github Actions pipeline in the fork.

## Inputs

### `remotetoken`

**Required** The token of the remote upstream repository. The scope of this token only needs read/write access for statuses.

### `previousstate`

**Required** The status of the current job. Needed to build the API call updating the status of the commit.

### `init`

This flag is used to create the `pending` status on the remote repository used only at the beginning of the pipeline. Default value is `false`

## Outputs

## Example usage

name: build

on: [push, pull_request]

env:
  UPSTREAM: softwareco

jobs:
  compile:
    runs-on: ubuntu-latest

    name: Compile
    steps:
      - name: Trigger Pending Status
        uses: tierconnect/github-actions-statuses@master
        with:
          remotetoken: ${{ secrets.GIT_TOKEN }}
          upstream: ${{ env.UPSTREAM }}
          previousstate: ${{ job.status }}
          init: true

      - name: Checkout
        uses: actions/checkout@v1

      - name: Trigger Finishing Status
        uses: tierconnect/github-actions-statuses@master
        with:
          remotetoken: ${{ secrets.GIT_TOKEN }}
          upstream: ${{ env.UPSTREAM }}
          previousstate: ${{ job.status }}
        if: always()
