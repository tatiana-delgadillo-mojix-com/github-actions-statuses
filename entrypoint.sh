#!/bin/sh -l

echo "Shell running with these variables: "

echo "GITHUB SHA: $GITHUB_SHA"
echo "GITHUB TOKEN: $GITHUB_TOKEN"
echo "GITHUB TOKEN INPUT: $INPUT_GITHUB_TOKEN"
echo "GITHUB REPO: ${GITHUB_REPOSITORY##*/}"
echo "PREV STATE: $INPUT_PREVIOUSSTATE"
echo "INIT STATE: $INPUT_INIT"
echo "UPSTREAM: $UPSTREAM"

go () {

    echo "Sending status: $INPUT_PREVIOUSSTATE"
    time curl --location --request POST "https://api.github.com/repos/$UPSTREAM/${GITHUB_REPOSITORY##*/}/statuses/$GITHUB_SHA" \
    --header 'Accept: application/vnd.github.antiope-preview+json' \
    --header "Authorization: Token $GITHUB_TOKEN" \
    --header 'Content-Type: application/json' \
    --data-raw "{
    \"state\": \"$INPUT_PREVIOUSSTATE\",
    \"target_url\": \"https://github.com/$UPSTREAM/${GITHUB_REPOSITORY##*/}/actions\",
    \"description\": \"${DESCRIPTION}\",
    \"context\": \"mojix/ci\"
    }"
}

if [ $INPUT_PREVIOUSSTATE == 'success' ] && [ $INPUT_INIT == 'false' ]; then export DESCRIPTION="The build succeeded!" && go;
elif [ $INPUT_PREVIOUSSTATE == 'failure' ] && [ $INPUT_INIT == 'false' ]; then export DESCRIPTION="The build failed!" && go;
elif [ $INPUT_INIT == 'true' ]; then export DESCRIPTION="The build is pending" && export INPUT_PREVIOUSSTATE='pending' && go; fi
