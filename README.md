
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]




<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/yupipi93/gitChecker">
    <img src="images/logo.png" alt="Logo" width="120" height="120">
  </a>

  <h3 align="center">GIT CHECKER - [BASH]</h3>

  <p align="center">
    A simple bash script to automate the updating of your projects!
    <br />
    <a href="https://github.com/yupipi93/gitChecker"><strong>Code »</strong></a>
    <br />
    <br />
    <a href="https://github.com/yupipi93/gitChecker/issues">Report Bug</a>
    ·
    <a href="https://github.com/yupipi93/gitChecker/issues">Request Feature</a>
  </p>
</p>


<!-- ABOUT THE PROJECT -->
## About The Project

GitChecker detects changes in your Git repository and lets you set up actions before, during, and after the project is updated.

A recurring use case for GitChecker is when we have the backend of our app hosted on a server where we want to up updates constantly.
GitChecker will detect the new changes in the repository and update the code with them.

All you have to do is upload the changes to your branch and GitChecker will do the rest.


### Built With

* [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
* [Git](https://git-scm.com/)


<!-- GETTING STARTED -->
## Getting Started

To get started, download GitChecker from this repository and copy it to your repository's root folder.
(We recommend downloading the zip and extracting it, not cloning it)

It is usually used in the production branch, when the code is on a remote server.

To run it, you need to go into the gitChecker folder and run 
```sh
./gitChecker.sh
```

Or you can run 
```sh
./gitChecker.sh -h 
```
to display help.

```
Syntax: ./gitChecker.sh [OPTIONS]
OPTIONS:
-b 'branch'   Branc name to check updates.        [DEFAULT:current]
-p 'path'     Path of repository folder.          [DEFAULT:..]
-u 'update'   Update time in minutes.             [DEFAULT:10]
-f            Force update. Discards local files. [DEFAULT:merge]
-h            Print this Help.
```

If you do not add any parameters, it will take the default values.
The opposite case, you can configure:

The branch where the changes are expected (usually the production branch)
Example: 
```sh
./gitChecker.sh -b production
```

The path where the target repository is located (you don't need to configure it if you put gitChecker into the root folder)
Example: 
```sh
./gitChecker.sh -p /home/USERNAME/MYREPO/
```

The waiting time between updates (default 10 minutes)
Example: ./gitChecker.sh -u 1 (will check for updates every 1 minute)

If we want to force the update (default merged)
Example 
```sh
./gitChecker.sh -f
```
You can choose the update method: Merged or Forced.
Merged (default): Merges local changes with remote changes. (may cause conflicts)
Forced: Discards local changes. (-f)

Complete example: 
```sh
./gitChecker.sh -b production -p /home/USERNAME/MyRepo/ -u 1 -f
```


<!-- LICENSE -->
## License

Public Domain.
Distributed under CC0 License. See `LICENSE.txt` for more information.
Free for all :D


<!-- CONTACT -->
## Contact

Sergio Conejero Vicente - [@twitter_handle](https://twitter.com/Yupipi93) - yupipi93@gmail.com

Project Link: [https://https://github.com/yupipi93/gitChecker](https://https://github.com/yupipi93/gitChecker)




<!-- Footer -->

[![License: CC0-1.0](https://licensebuttons.net/l/zero/1.0/80x15.png)](http://creativecommons.org/publicdomain/zero/1.0/)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/yupipi93/gitChecker.svg?style=flat-square
[contributors-url]: https://github.com/yupipi93/gitChecker/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/yupipi93/gitChecker.svg?style=flat-square
[forks-url]: https://github.com/yupipi93/gitChecker/network/members
[stars-shield]: https://img.shields.io/github/stars/yupipi93/gitChecker.svg?style=flat-square
[stars-url]: https://github.com/yupipi93/gitChecker/stargazers
[issues-shield]: https://img.shields.io/github/issues/yupipi93/gitChecker.svg?style=flat-square
[issues-url]: https://github.com/yupipi93/gitChecker/issues
[license-shield]: https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg?style=flat-square
[license-url]: https://github.com/yupipi93/gitChecker/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/sergio-conejero-vicente-61226aa5/
[product-screenshot]: images/screenshot.png

