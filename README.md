# Bhav Vriksha
Hindi Sentiment Treebank

> [Archive Note] @parulsethi and I had fun making this toy project. I will add some note on how the code was organised. For me it was an experiment to learn d3, coffeescript (I miss it), and some web development attempts  As such the code is _not_ the best, but is a patched up together to do a few simple things:

- @parulsethi had an assignment in NLP course at school, where she wanted to learn how to use python for doing sentiment analysis/parsing in Hindi. She didnt have enough data, :9 we made this tool for loading a bunch of text on website and then use the tool to make it faster to create our dataset in Hindi Parts-Of-Speech with Sentiment Analysis tagging.

Naturally, it would have been faster to just manually do it  But whats' the fun in  that?

I might add some docs, but you can play with it on the website meanwhile  



## Getting Started

Hi there!

To get started with Bhav Vriksha

## Push data

```bash
function to_bhavriksha {
  curl -F "file=@$1" https://file.io | \
    grep -E '"link":".+' -o | \
    cut -c9-30 | \
    heroku run -a bhavriksha xargs curl  \| python -m vatika.treebank
    
    .migrate
}
```
