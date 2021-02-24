# autoarch
an easy arch installer.

## installation
it is recommended to use the [autoarchiso](https://github.com/hhhhhhhhhn/autoarchiso).
if you do, just use the "base" install and follow the instructions.

if you want to install manually, run the following commands:

```bash
pacman -S git
git clone https://github.com/hhhhhhhhhn/autoarch
cd autoarch
./install
```

soon, a fully functional arch installation will be complete.

## development
to create a custom autoarch installer, you just need to modify the [scripts/](./scripts) folder.
here, note that the name of the scripts is important:

- if the name includes neither, it will be run from the installer
- if the name includes "chroot", it will be run in the chroot, in the root directory of the install
- if the name includes "user", it will be run in the chroot in the user's home directory as that user
- after those rules, scripts are run in numerical order

use `#: NAME` to denote the steps being taken to show them in the progress bar

some important enviroment variables are available to you,
namely the ones from the [install](./install) script.

see the [default scripts/ folder](./scripts) for an example
