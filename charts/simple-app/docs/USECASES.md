# Multi-chart with common SA

```
global:
    serviceAccount:
        name: xxx

chart1:
    # nothing about SA
```

# Multi-chart with common SA and override in one subchart

```
global:
    serviceAccount:
        name: xxx

chart1:
    # nothing about SA; uses global

chart2:
    serviceAccount:
        create
```

# Multi-chart with separate SA

```
global:
    # nothing about SA

chart1:
    # nothing about SA
```

# Multi-chart with pre-existing SA per subchart

```
global:
    # nothing about SA

chart1:
    serviceAccount:
        create: false
        name: existing-sa-name
```
