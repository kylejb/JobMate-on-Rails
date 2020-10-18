# Contributing Guide

Thank you so much for your interest in contributing! All types of contributions are encouraged and valued. See below for guidelines on how to help.

## Request Support

If you have questions about this project, how to use it, or just need clarification about something:

- [Open an issue](https://github.com/kylejb/JobMate/issues) and provide as much context as you can; you should also include project and platform versions, if applicable to your situation.

- If you do not respond to the issue for 30 days, the issue will be closed. 

- Please avoid filing new issues as extensions of one you already made; if you wish to reopen a closed issue, reply once and we'll reopen it.

## Submitting changes

- Fork the repo
  - <https://github.com/kylejb/JobMate/fork>
- Check out a new branch based and name it to what you intend to do:
  - Example:
    ````
    $ git checkout -b BRANCH_NAME
    ````
    If you get an error, you may need to fetch main first by using
    ````
    $ git remote update && git fetch
    ````
  - Use one branch per fix / feature
- [Sign](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/signing-commits) and commit your changes:
  - Provide a git message that explains what you've done
  - Make sure your commits follow the [conventions](https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53#file-commit-message-guidelines-md)
  - Commit to the forked repository
  - Example:
    ````
    $ git commit -am 'Added some fooBar'
    ````
- Push to the branch
  - Example:
    ````
    $ git push origin BRANCH_NAME
    ````
- Make a pull request
  - Make sure you send the PR to the <code>main</code> branch
  - Travis CI is watching you!

If you follow these instructions, your PR will land pretty safely in the main repo!
