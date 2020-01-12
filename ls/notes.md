Install GNU version:

```
nix-env -iA nixpkgs.coreutils-full
```

Installing the `-full` version because it includes the manpages; the regular
`coreutils` derivation does not.

