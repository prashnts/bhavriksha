# Bhav Vriksha
Hindi Sentiment Treebank

## Getting Started

Hi there!

To get started with Bhav Vriksha

## Push data

```bash
function to_bhavriksha {
  curl -F "file=@$1" https://file.io | \
    grep -E '"link":".+' -o | \
    cut -c9-30 | \
    heroku run -a ${$2:vatika} xargs curl  \| python -m vatika.treebank.migrate
}
```
