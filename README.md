# Bhav Vriksha
Hindi Sentiment Treebank

## Getting Started

Hi there!

To get started with Bhav Vriksha

## Push data

```bash

curl -F "file=@sentiment-treebank-z.txt" https://file.io | \
  jq -r '.link | tostring' | \
  heroku run xargs curl  \| python -m vatika.treebank.migrate

```
