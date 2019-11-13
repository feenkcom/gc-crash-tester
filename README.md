# gtoolkit-crasher
I contain a lot of auto generated code to reproduce garbage collector crash

## Load generated code

```smalltalk
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkitCrasherGenerated';
    repository: 'github://feenkcom/gtoolkit-crasher/src';
    load
] ensure: [ EpMonitor current enable ].
```

## Load generators

```smalltalk
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkitCrasher';
    repository: 'github://feenkcom/gtoolkit-crasher/src';
    load
] ensure: [ EpMonitor current enable ].
```

## Generation

The following will generate one class prefixed `GtCrasherGenerated` in `GToolkit-CrasherGenerated` package
```smalltalk
GtCrasherClassGenerator new
  createClassesPrefixed: 'GtCrasherGenerated'
  packaged: 'GToolkit-CrasherGenerated'
  amount: 1
```

Before trying this make sure to remove already generated 'GToolkit-CrasherGenerated' package or choose a different name
