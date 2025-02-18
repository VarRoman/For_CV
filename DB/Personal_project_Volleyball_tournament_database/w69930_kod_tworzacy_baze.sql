USE [w69930_PROJEKT]
GO
/****** Object:  Table [dbo].[Dochody_Wydatki]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dochody_Wydatki](
	[towary] [varchar](50) NULL,
	[kolor] [varchar](50) NULL,
	[ilość_zakupu] [int] NULL,
	[ilość_sprzedanych] [int] NULL,
	[cena] [float] NULL,
	[firma_sprzedaży] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gierki_Ligy_Siatkarskej]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gierki_Ligy_Siatkarskej](
	[numer_gry] [int] IDENTITY(1,1) NOT NULL,
	[cykl_rozgrywki] [varchar](30) NULL,
	[id_sedziego] [int] NULL,
	[id_pierwszej_druzyny] [int] NULL,
	[id_drugiej_druzyny] [int] NULL,
	[id_przegrywającej_druzyny] [int] NULL,
	[id_wygrywającej_druzyny] [int] NULL,
	[numer_kortu] [int] NULL,
	[czas_meczu] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[numer_gry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gracze]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gracze](
	[id_gracza] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](50) NULL,
	[nazwisko] [varchar](50) NULL,
	[plec] [varchar](10) NULL,
	[data_urodzenia] [date] NULL,
	[email] [varchar](100) NULL,
	[telefon] [varchar](20) NULL,
	[adres] [varchar](255) NULL,
	[pozycja] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_gracza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InfoDruzyny]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InfoDruzyny](
	[id_druzyny] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [varchar](30) NULL,
	[id_trenera] [int] NULL,
	[data_rejestracji] [date] NULL,
	[email] [varchar](100) NULL,
	[adres_rejestracji] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_druzyny] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Klienci]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klienci](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](100) NOT NULL,
	[nazwisko] [varchar](100) NOT NULL,
	[plec] [varchar](10) NOT NULL,
	[email] [varchar](150) NULL,
	[telefon] [varchar](30) NULL,
	[miejsce] [varchar](15) NULL,
	[czas_zakupu_biletu] [datetime] NULL,
	[zaplacono] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organizatorzy]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizatorzy](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](100) NOT NULL,
	[nazwisko] [varchar](100) NOT NULL,
	[plec] [varchar](10) NOT NULL,
	[email] [varchar](150) NULL,
	[telefon] [varchar](30) NULL,
	[miejsce] [varchar](15) NULL,
	[status_zaproszenia] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PozycjeDruzyny]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PozycjeDruzyny](
	[id_druzyny] [int] NOT NULL,
	[trener] [int] NOT NULL,
	[atakujacy] [int] NOT NULL,
	[rozgrywajacy] [int] NOT NULL,
	[przyjmujacy] [int] NOT NULL,
	[srodkowy] [int] NOT NULL,
	[libero] [int] NOT NULL,
	[rezerwowy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_druzyny] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sedziowie]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sedziowie](
	[id_sedziego] [int] NOT NULL,
	[imie] [varchar](50) NULL,
	[nazwisko] [varchar](50) NULL,
	[plec] [varchar](10) NULL,
	[data_urodzenia] [date] NULL,
	[email] [varchar](100) NULL,
	[telefon] [varchar](20) NULL,
	[adres] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sedziego] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sponsory_Druzyny]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sponsory_Druzyny](
	[id_druzyny] [int] NOT NULL,
	[nazwa] [varchar](50) NULL,
	[imie] [varchar](50) NULL,
	[nazwisko] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[telefon] [varchar](20) NULL,
	[adres] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_druzyny] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sponsory_Gierok]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sponsory_Gierok](
	[numer_gry] [int] NOT NULL,
	[nazwa] [varchar](50) NULL,
	[imie] [varchar](50) NULL,
	[nazwisko] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[telefon] [varchar](20) NULL,
	[adres] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[numer_gry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statystyki_Gierok]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statystyki_Gierok](
	[numer_gry] [int] NOT NULL,
	[procent_ataku] [float] NULL,
	[procent_przyjec] [float] NULL,
	[procent_serwow] [float] NULL,
	[punkty_ataku] [int] NULL,
	[punkty_bloku] [int] NULL,
	[punkty_serwow] [int] NULL,
	[ilość_wymian] [int] NULL,
	[ilość_żółtych_kartek] [int] NULL,
	[ilość_czerwonych_kartek] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[numer_gry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatystykiDruzyny]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatystykiDruzyny](
	[id_druzyny] [int] NOT NULL,
	[procent_ataku] [float] NULL,
	[procent_przyjec] [float] NULL,
	[procent_serwow] [float] NULL,
	[punkty_ataku] [int] NULL,
	[punkty_bloku] [int] NULL,
	[punkty_serwow] [int] NULL,
	[ilość_zawodników] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_druzyny] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatystykiGracza]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatystykiGracza](
	[id_gracza] [int] NOT NULL,
	[procent_ataku] [float] NULL,
	[procent_przyjec] [float] NULL,
	[procent_serwow] [float] NULL,
	[punkty_ataku] [int] NULL,
	[punkty_bloku] [int] NULL,
	[punkty_serwow] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_gracza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trenery]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trenery](
	[id_trenera] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](50) NULL,
	[nazwisko] [varchar](50) NULL,
	[plec] [varchar](10) NULL,
	[data_urodzenia] [date] NULL,
	[email] [varchar](100) NULL,
	[telefon] [varchar](20) NULL,
	[adres] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_trenera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zakupy]    Script Date: 10.01.2025 02:32:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zakupy](
	[id] [int] NOT NULL,
	[source] [varchar](15) NOT NULL,
	[bonus] [varchar](50) NULL,
	[flagi] [int] NULL,
	[naklejki] [int] NULL,
	[gwizdki] [int] NULL,
	[autografy_graczy] [int] NULL,
	[koszty_z_osoby] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[source] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO