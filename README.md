# Bilibili 今日前100排行

这是一个使用 **Flutter** 和 **Clean Architecture** 架构的项目，旨在获取 Bilibili 当日的前 100 排行榜数据。数据通过 API 获取，并使用 **Floor 数据库** 进行本地缓存。


## 项目架构

```mermaid
flowchart TD
    %% View 层

    A[View] --> DE[Dispatches Events]
    DE --> B[BLoC]
    B --> LU[Use Case]
    LU --> R[Repository Interface]
    
    %% Domain 层
    R --> D[Repository Implementation]
    D --> DS[Data Source Interface]
    DS --> API[Remote API / Local DB]
    LU --> Entity[Entity]

    %% Data 层
    D --> DS
    DS --> API
    D --> MD[Model]
    
    %% State Updates
    B --> SU[State Updates]
    SU --> A[View]
    A --> UD[UI Displays Data]

    subgraph Presentation[Presentation Layer]
        A
        DE
        B
        SU
        UD
    end

    subgraph Domain[Domain Layer]
        LU
        R
        Entity
    end

    subgraph Data[Data Layer]
        D
        DS
        API
        MD
    end
