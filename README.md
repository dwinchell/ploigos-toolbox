This is a mocked up demo of what the user experience of the ploigos step runner could be.

# Installing in CodeReady Workspaces

Add this to your Devfile
```
  - container:
      args:
        - '-f'
        - /dev/null
      command:
        - tail
      image: quay.io/dwinchell_redhat/ploigos-toolbox
      memoryLimit: 512M
      mountSources: true
      sourceMapping: /projects
    name: ploigos
```

# Installing Locally
The mocking aliases some conosole commands. To install:
```
source ./bin/install
```

To uninstall and get your real commands back:
```
source ./bin/uninstall
```

