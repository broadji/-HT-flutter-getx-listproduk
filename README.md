# ht_flutter_getx_listproduk

## Discovering Project
After setting up all the needed thing now lets talk about folder structure which is mainly based on Getx Pattern and there are some personal opinions, if you open your lib folder you will find those folders

```
.
└── lib
    ├── core
    │   ├── components
    │   ├── config
    │   ├── routes
    │   ├── utils
    ├── data
    │   ├── local
    │   │   ├── db
    │   │   └── prefs
    │   ├── network
    │   │   ├── services
    │   │   api_repository 
    │   └── repositories
    ├── domain
    │   └── models
    └── persentation
        └── [modular]
             ├── controller
             └── pages
```

- core: will contain all our core app 
- data: will contain fetching services
- domain: contains all moduls and entites
- persentation: contains all modular project and state management