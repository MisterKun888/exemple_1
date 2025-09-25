/*==============================================================*/
/* Nom de SGBD :  Microsoft SQL Server 2008                     */
/* Date de création :  22/09/2025 10:11:41                      */
/*==============================================================*/


if exists (select 1
            from  sysindexes
           where  id    = object_id('DECISION_FINALE')
            and   name  = 'DECIDE_FK'
            and   indid > 0
            and   indid < 255)
   drop index DECISION_FINALE.DECIDE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DECISION_FINALE')
            and   type = 'U')
   drop table DECISION_FINALE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GESTION')
            and   name  = 'AVOIR_INSTRUCTION_CCCA_FK'
            and   indid > 0
            and   indid < 255)
   drop index GESTION.AVOIR_INSTRUCTION_CCCA_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GESTION')
            and   name  = 'AVOIR_PRE_INSTRUCTION_FK'
            and   indid > 0
            and   indid < 255)
   drop index GESTION.AVOIR_PRE_INSTRUCTION_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GESTION')
            and   name  = 'ETRE_GERE_FK'
            and   indid > 0
            and   indid < 255)
   drop index GESTION.ETRE_GERE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GESTION')
            and   type = 'U')
   drop table GESTION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('INSTRUCTION_CCCA')
            and   name  = 'METTRE_PRIORITE_FK'
            and   indid > 0
            and   indid < 255)
   drop index INSTRUCTION_CCCA.METTRE_PRIORITE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('INSTRUCTION_CCCA')
            and   type = 'U')
   drop table INSTRUCTION_CCCA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MONTANT_A_REGLER')
            and   name  = 'ASSOCIATION_30_FK'
            and   indid > 0
            and   indid < 255)
   drop index MONTANT_A_REGLER.ASSOCIATION_30_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MONTANT_A_REGLER')
            and   type = 'U')
   drop table MONTANT_A_REGLER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PRE_INSTRUCTION')
            and   name  = 'GERER_FK'
            and   indid > 0
            and   indid < 255)
   drop index PRE_INSTRUCTION.GERER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRE_INSTRUCTION')
            and   type = 'U')
   drop table PRE_INSTRUCTION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_3CA_BTP')
            and   type = 'U')
   drop table USER_3CA_BTP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_ADMIN')
            and   type = 'U')
   drop table USER_ADMIN
go

/*==============================================================*/
/* Table : DECISION_FINALE                                      */
/*==============================================================*/
create table dbo.DECISION_FINALE (
   ID_DECISION_FINALE   numeric              identity,
   ID_USER_ADMIN        numeric              not null,
   PRIORITE_CONSTRUCTYS varchar(255)         null,
   COMMENTAIRES_CONSTRUCTYS varchar(5000)        null,
   MONTANT_TOTAL_JUSTIFICATIF varchar(255)         null,
   SUBVENTION_TOTALE    varchar(255)         null,
   SUBVENTION_TOTALE_POURCENTAGE varchar(255)         null,
   ACCORDE              bit                  null,
   constraint PK_DECISION_FINALE primary key nonclustered (ID_DECISION_FINALE)
)
go

/*==============================================================*/
/* Index : DECIDE_FK                                            */
/*==============================================================*/
create index DECIDE_FK on DECISION_FINALE (
ID_USER_ADMIN ASC
)
go

/*==============================================================*/
/* Table : GESTION                                              */
/*==============================================================*/
create table dbo.GESTION (
   ID_GESTION           numeric              identity,
   ID_INSTRUCTION_CCCA  numeric              not null,
   ID_PRE_INSTRUCTION   numeric              not null,
   ID_DEMANDE           numeric              not null,
   constraint PK_GESTION primary key nonclustered (ID_GESTION)
)
go

/*==============================================================*/
/* Index : ETRE_GERE_FK                                         */
/*==============================================================*/
create index ETRE_GERE_FK on GESTION (
ID_DEMANDE ASC
)
go

/*==============================================================*/
/* Index : AVOIR_PRE_INSTRUCTION_FK                             */
/*==============================================================*/
create index AVOIR_PRE_INSTRUCTION_FK on GESTION (
ID_PRE_INSTRUCTION ASC
)
go

/*==============================================================*/
/* Index : AVOIR_INSTRUCTION_CCCA_FK                            */
/*==============================================================*/
create index AVOIR_INSTRUCTION_CCCA_FK on GESTION (
ID_INSTRUCTION_CCCA ASC
)
go

/*==============================================================*/
/* Table : INSTRUCTION_CCCA                                     */
/*==============================================================*/
create table dbo.INSTRUCTION_CCCA (
   ID_INSTRUCTION_CCCA  numeric              identity,
   ID_USER_3CA_BTP      numeric              not null,
   PRIORITE_CCCA        varchar(255)         null,
   MONTANT_RETENU_EUROS varchar(255)         null,
   SUBVENTION_RETENU_EUROS varchar(255)         null,
   COMMENTAIRE_CCCA     varchar(5000)        null,
   TRANSMISSION_OPCO    bit                  null,
   DATE_DE_TRANSMISSION_OPCO varchar(255)         null,
   constraint PK_INSTRUCTION_CCCA primary key nonclustered (ID_INSTRUCTION_CCCA)
)
go

/*==============================================================*/
/* Index : METTRE_PRIORITE_FK                                   */
/*==============================================================*/
create index METTRE_PRIORITE_FK on INSTRUCTION_CCCA (
ID_USER_3CA_BTP ASC
)
go

/*==============================================================*/
/* Table : MONTANT_A_REGLER                                     */
/*==============================================================*/
create table dbo.MONTANT_A_REGLER (
   ID_MONTANT_A_REGLER  numeric              identity,
   ID_DECISION_FINALE   numeric              not null,
   MONTANT_TOTAL_JUSTIFICATIF varchar(255)         null,
   SUBVENTION_TOTALE_ACCORDEE varchar(255)         null,
   TOTAL_A_REGLER       varchar(255)         null,
   TOTAL_OU_PARTIEL     varchar(255)         null,
   DIFFERENCE           varchar(255)         null,
   constraint PK_MONTANT_A_REGLER primary key nonclustered (ID_MONTANT_A_REGLER)
)
go

/*==============================================================*/
/* Index : ASSOCIATION_30_FK                                    */
/*==============================================================*/
create index ASSOCIATION_30_FK on MONTANT_A_REGLER (
ID_DECISION_FINALE ASC
)
go

/*==============================================================*/
/* Table : PRE_INSTRUCTION                                      */
/*==============================================================*/
create table dbo.PRE_INSTRUCTION (
   ID_PRE_INSTRUCTION   numeric              identity,
   ID_USER_ADMIN        numeric              not null,
   DIRECTION_REGIONALE  varchar(255)         null,
   DEVIS                bit                  null,
   DATE_RELANCE         varchar(255)         null,
   MOTIF_RELANCE        varchar(5000)        null,
   COMMENTAIRE_POUR_CCCA varchar(5000)        null,
   TRANSMISSION_CCCA    bit                  null,
   DATE_DE_TRANSMISSION_CCCA varchar(255)         null,
   constraint PK_PRE_INSTRUCTION primary key nonclustered (ID_PRE_INSTRUCTION)
)
go

/*==============================================================*/
/* Index : GERER_FK                                             */
/*==============================================================*/
create index GERER_FK on PRE_INSTRUCTION (
ID_USER_ADMIN ASC
)
go

/*==============================================================*/
/* Table : USER_3CA_BTP                                         */
/*==============================================================*/
create table dbo.USER_3CA_BTP (
   ID_USER_3CA_BTP      numeric              identity,
   NOM_USER_3CABTP      varchar(255)         null,
   PRENOM_USER_3CABTP   varchar(255)         null,
   EMAIL_USER_3CABTP    varchar(255)         null,
   constraint PK_USER_3CA_BTP primary key nonclustered (ID_USER_3CA_BTP)
)
go

/*==============================================================*/
/* Table : USER_ADMIN                                           */
/*==============================================================*/
create table dbo.USER_ADMIN (
   ID_USER_ADMIN        numeric              identity,
   NOM_USERADMIN        varchar(255)         null,
   PRENOM_USERADMIN     varchar(255)         null,
   EMAIL_USERADMIN      varchar(255)         null,
   constraint PK_USER_ADMIN primary key nonclustered (ID_USER_ADMIN)
)
go

