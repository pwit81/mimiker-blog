Title: #1 weekly progress report
Date: 2019-11-21 10:20
Category: Mimiker blog 

Good news everyone, we start posting weekly updates on Mimiker kernel
development. Read below what our team has coded recently!

### `ioctl` syscall

As [NetBSD manpage](https://netbsd.gw.com/cgi-bin/man-cgi?ioctl) says

> The ioctl() function manipulates the underlying device parameters of
special files.  In particular, many operating characteristics of
character special files (e.g. terminals) may be controlled with
ioctl() requests.

And that's precisely the reason we need `ioctl`. Mimiker terminal
handling capabilities are mediocre. We need colors, fonts and special
characters support in order to implement genuine terminal
handling.
[comment]: <> ([commit](https://github.com/cahirwpz/mimiker/commit/9794baa2c9f191b9e6190f19ebe242887a1ba8c8))

### NetBSD userland port

No OS kernel itself poses any value to end users. Therefore an
extensive effort is being put to run useful stuff on top of Mimiker
kernel. We already have some success stories here, like running Doom
(in non-interactive mode) and lua script interpreter, but more
elementary command-line tools are needed. Our latest codebase brings in
addition to simple NetBSD ports of `/usr/bin` tools (`cat`, `cmp`,
`col`, `cut`, `echo`, `find`, `head`, `grep`, `join`, `kill`, `sed`,
`tail`, `tr`, `wc`), the Korn Shell interpreter `ksh`. Though not
fully functional yet, it will provide true Unix experience!

### syscalls cleanup

Things stop working from time to time. Earlier transformations of
system call framework introduced bugs to `getdirentries` and `execve`
syscalls, thus making `ls` command and `lua` interpreter crashy. This
has been fixed.

### progress in signal handling

Stdlib functions `setjmp`/`longjmp` now save/restore
signal mask. Earlier implementations didn't and that was another
reason for buggy `lua`.

[comment]: <> (naprawienie getdirentries przywróciło ls dołożenie ioctl pozwoli nam zrobić obsługę terminala • naprawienie execve przywróciło działanie skryptów lua • dołożyliśmy wywołania systemowe, które przywróciły działanie setjmp i longjmp (lua + ksh powróciły do życia))
