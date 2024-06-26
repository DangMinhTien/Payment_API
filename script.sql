USE [Payment_API]
GO
/****** Object:  Schema [HangFire]    Script Date: 6/10/2024 12:30:13 AM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[Merchant]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchant](
	[Id] [nvarchar](50) NOT NULL,
	[MerchantName] [nvarchar](250) NULL,
	[MerchantWebLink] [nvarchar](550) NULL,
	[MerchantIpnUrl] [nvarchar](550) NULL,
	[MerchantReturnUrl] [nvarchar](550) NULL,
	[SecretKey] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [nvarchar](550) NULL,
	[LastUpdatedBy] [nvarchar](550) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Merchant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[Id] [nvarchar](50) NOT NULL,
	[PaymentContent] [nvarchar](250) NULL,
	[PaymentCurrency] [nvarchar](10) NULL,
	[PaymentRefId] [nvarchar](50) NULL,
	[RequiredAmount] [decimal](19, 2) NULL,
	[PaymentDate] [datetime] NULL,
	[ExpireDate] [datetime] NULL,
	[PaymentLanguage] [nvarchar](10) NULL,
	[MerchantId] [nvarchar](50) NULL,
	[PaymentDestinationId] [nvarchar](50) NULL,
	[PaidAmount] [decimal](19, 2) NULL,
	[PaymentStatus] [nvarchar](20) NULL,
	[PaymentLastMessage] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](250) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdatedBy] [nvarchar](250) NULL,
	[LastUpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentDestination]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentDestination](
	[id] [nvarchar](50) NOT NULL,
	[DesLogo] [nvarchar](250) NULL,
	[DesShortName] [nvarchar](150) NULL,
	[DesName] [nvarchar](250) NULL,
	[DesSortIndex] [int] NULL,
	[ParentId] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [nvarchar](250) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdatedBy] [nvarchar](250) NULL,
	[LastUpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_PaymentDestination] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentNotification]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentNotification](
	[Id] [nvarchar](50) NOT NULL,
	[PaymentRefId] [nvarchar](50) NULL,
	[NotiDate] [nvarchar](50) NULL,
	[NotiAmount] [nvarchar](50) NULL,
	[NotiContent] [nvarchar](550) NULL,
	[NotiMessage] [nvarchar](550) NULL,
	[NotiSignature] [nvarchar](550) NULL,
	[PaymentId] [nvarchar](50) NULL,
	[MerchantId] [nvarchar](50) NULL,
	[NotiStatus] [nvarchar](50) NULL,
	[NotiRefDate] [nvarchar](50) NULL,
 CONSTRAINT [PK_PaymentNotification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentSignature]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentSignature](
	[Id] [nvarchar](50) NOT NULL,
	[SignValue] [nvarchar](500) NULL,
	[SignAlgo] [nvarchar](500) NULL,
	[SignDate] [datetime] NULL,
	[SignOwn] [nvarchar](550) NULL,
	[PaymentId] [nvarchar](50) NULL,
	[IsValid] [bit] NULL,
 CONSTRAINT [PK_PaymentSignature] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentTransaction]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTransaction](
	[Id] [nvarchar](50) NOT NULL,
	[TranMessage] [nvarchar](550) NULL,
	[TranPayload] [nvarchar](550) NULL,
	[TranStatus] [nvarchar](20) NULL,
	[TranAmount] [decimal](19, 2) NULL,
	[TranDate] [datetime] NULL,
	[PaymentId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](250) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdatedBy] [nvarchar](250) NULL,
	[LastUpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_PaymentTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_HangFire_Counter] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Merchant] ([Id], [MerchantName], [MerchantWebLink], [MerchantIpnUrl], [MerchantReturnUrl], [SecretKey], [IsActive], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'Website bán hàng', N'https://webbanhang.com', N'https://webbanhang/ipn.com', N'https://webbanhang.com/payment/return', N'6A40BB85-BE10-4EBA-8E42-4860AFB0E5AE', 0, N'', NULL, CAST(N'2024-06-05T03:15:50.847' AS DateTime), NULL)
GO
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'08d72c61-53b1-403b-8bc2-b4f46fd3382e', N'Thanh toán đơn hàng 1000', N'VND', N'string', CAST(340000.00 AS Decimal(19, 2)), CAST(N'2024-06-06T13:02:14.793' AS DateTime), CAST(N'2024-06-06T13:17:15.220' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-06T13:02:15.220' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'16ed383d-2ba5-4776-a6dc-7b8f86ed3fc5', N'thanh toán cho đơn 2801200268TI ', N'VND', N'string', CAST(0.00 AS Decimal(19, 2)), CAST(N'2024-06-05T15:19:12.657' AS DateTime), CAST(N'2024-06-05T15:34:12.953' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-05T15:19:12.953' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'29c157b6-12b3-4bc5-9a4d-fd10be0570e6', N'thanh toán cho đơn 2801200268TI ', N'VND', N'string', CAST(20000.00 AS Decimal(19, 2)), CAST(N'2024-06-05T15:19:53.373' AS DateTime), CAST(N'2024-06-05T15:34:53.377' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-05T15:19:53.377' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'2ef05fef-6b3b-4a9e-a761-637143ec9c79', N'Thanh toán đơn hàng 1200MTS', N'string', N'string', CAST(0.00 AS Decimal(19, 2)), CAST(N'2024-06-05T11:48:19.610' AS DateTime), CAST(N'2024-06-05T12:03:19.610' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-05T11:48:19.610' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'35793c76-5b99-4a94-8999-03cb350ab54e', N'Thanh toán hóa đơn 1200', N'VND', N'string', CAST(300000.00 AS Decimal(19, 2)), CAST(N'2024-06-06T09:44:03.893' AS DateTime), CAST(N'2024-06-06T09:59:04.387' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-06T09:44:04.390' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'383d5a57-1bf9-45fa-8306-a9b173859652', N'Thanh toán đơn hàng DH65345693428012002', N'VND', N'afsdfsfg', CAST(200000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:25:25.753' AS DateTime), CAST(N'2024-06-08T14:40:26.207' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:25:26.207' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'46d98642-dd2d-466d-a63c-1f279f60f758', N'Thanh toán đơn hàng Đ28012002', N'VND', N'098ha899', CAST(236000.00 AS Decimal(19, 2)), CAST(N'2024-06-06T16:12:59.123' AS DateTime), CAST(N'2024-06-06T16:27:59.983' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'MOMO', NULL, NULL, NULL, N'', CAST(N'2024-06-06T16:12:59.983' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'5191e102-8a38-4ecd-8649-717ea96cab37', N'Thanh toán đơn mua 202068TI', N'string', N'string', CAST(0.00 AS Decimal(19, 2)), CAST(N'2024-06-05T15:02:06.630' AS DateTime), CAST(N'2024-06-05T15:17:07.307' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-05T15:02:07.310' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'866c59cc-49d5-4103-af3f-2bb2bdd360f0', N'Thanh toán hóa đơn DH001222334', N'VND', N'string', CAST(24833000.00 AS Decimal(19, 2)), CAST(N'2024-06-06T11:05:36.627' AS DateTime), CAST(N'2024-06-06T11:20:36.863' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-06T11:05:36.863' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'9b65f4e2-5e23-473f-8c88-1f6112a80b01', N'Thanh toán đơn hàng 2801200268TI', N'string', N'string', CAST(0.00 AS Decimal(19, 2)), CAST(N'2024-06-05T15:10:20.617' AS DateTime), CAST(N'2024-06-05T15:25:20.877' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-05T15:10:20.877' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'9c44a202-ef40-40cb-a883-39d3759cbe4d', N'Thanh toán đơn hàng DH65345693428012002', N'VND', N'afsdfsfg', CAST(20000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:28:55.450' AS DateTime), CAST(N'2024-06-08T14:43:55.453' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:28:55.453' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'ac46d7ee-869b-450b-943c-110f3e224391', N'Thanh toán hóa đơn DH001222334', N'VND', N'string', CAST(248000.00 AS Decimal(19, 2)), CAST(N'2024-06-06T11:06:11.670' AS DateTime), CAST(N'2024-06-06T11:21:11.673' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-06T11:06:11.673' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'b23fc216-803f-40dd-a05e-75f4c70bb836', N'THANh toán đơn hàng DH28012002874', N'VND', N'string', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:34:36.247' AS DateTime), CAST(N'2024-06-08T14:49:36.480' AS DateTime), N'vn', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:34:36.480' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'b386f100-4eb8-47cc-827e-bb6a60484f50', N'thanh toán đơn hàng dh187391', N'VND', N'ORD15179', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:39:11.980' AS DateTime), CAST(N'2024-06-08T14:54:12.190' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:39:12.190' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'b4c43d34-b374-44c5-86c9-8b826b8a7957', N'thanh toán hóa đơn 28012003', N'VND', N'string', CAST(300000.00 AS Decimal(19, 2)), CAST(N'2024-06-06T09:52:06.733' AS DateTime), CAST(N'2024-06-06T10:07:06.937' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'VNPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-06T09:52:06.937' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'b7c13067-a422-4d20-8e0d-b74a6b481a81', N'Thanh toán đơn hàng DH65345693', N'VND', N'ORD1234', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:30:50.980' AS DateTime), CAST(N'2024-06-08T14:45:50.983' AS DateTime), N'vn', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:30:50.983' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'c820e417-516c-4cc7-ad25-90e4ee33dd22', N'Thanh toán đơn hàng DH65345693428012002', N'VND', N'afsdfsfg', CAST(20000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:29:36.047' AS DateTime), CAST(N'2024-06-08T14:44:36.053' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:29:36.053' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'd4bc5e1c-1adf-494a-b73c-84b4e154c305', N'Thanh toán đơn hàng DH65345693428012002', N'VND', N'afsdfsfg', CAST(200000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:27:09.793' AS DateTime), CAST(N'2024-06-08T14:42:09.800' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'MOMO', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:27:09.800' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'e87743ef-9c80-405e-8bd2-01341c032cbb', N'Thanh toán đơn hàng', N'VND', N'ORD151637', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:37:36.593' AS DateTime), CAST(N'2024-06-08T14:52:37.010' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:37:37.010' AS DateTime), NULL, NULL)
INSERT [dbo].[Payment] ([Id], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [PaymentDestinationId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'ea522690-7909-4363-8be1-c7cdadd22f86', N'ddfgdfh', N'VND', N'string', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-06-08T14:40:49.057' AS DateTime), CAST(N'2024-06-08T14:55:49.263' AS DateTime), N'string', N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ZALOPAY', NULL, NULL, NULL, N'', CAST(N'2024-06-08T14:40:49.263' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PaymentDestination] ([id], [DesLogo], [DesShortName], [DesName], [DesSortIndex], [ParentId], [IsActive], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'MOMO', N'https://momodeveloper.com.vn/image/logo.png', N'MOMO', N'Ví điện tử momo', 0, NULL, NULL, N'ĐẶNG MINH TIẾN', CAST(N'2024-06-06T16:07:31.223' AS DateTime), NULL, NULL)
INSERT [dbo].[PaymentDestination] ([id], [DesLogo], [DesShortName], [DesName], [DesSortIndex], [ParentId], [IsActive], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'VNPAY', N'https://sandbox.vnpayment.vn/apis/asset/image/partner_app.png', N'VNPAY', N'Cổng thanh toán VnPay', 0, NULL, NULL, N'Admin', CAST(N'2024-06-05T10:53:13.207' AS DateTime), NULL, NULL)
INSERT [dbo].[PaymentDestination] ([id], [DesLogo], [DesShortName], [DesName], [DesSortIndex], [ParentId], [IsActive], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt]) VALUES (N'ZALOPAY', N'http://sandbox.zalopay.vn/image/logo.png', N'ZALOPAY', N'Ví điện tử Zalo Pay', 0, NULL, NULL, N'Admin', CAST(N'2024-06-08T14:17:07.927' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'035049C4-44E8-4FE6-9764-8EAE4E82CD1A', N'shgfdskgf', NULL, CAST(N'2024-06-08T14:28:55.453' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'9c44a202-ef40-40cb-a883-39d3759cbe4d', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'0A9371E4-A391-4224-8449-501210207DD3', N'shgfdskgf', NULL, CAST(N'2024-06-08T14:25:26.210' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'383d5a57-1bf9-45fa-8306-a9b173859652', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'16A8E467-22B9-4E36-9561-806B55CE467E', N'string', NULL, CAST(N'2024-06-05T15:19:53.377' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'29c157b6-12b3-4bc5-9a4d-fd10be0570e6', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'1A508F81-9666-4108-A56C-E5DE1782D600', N'shgfdskgf', NULL, CAST(N'2024-06-08T14:30:50.983' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'b7c13067-a422-4d20-8e0d-b74a6b481a81', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'279DC606-EA47-48FC-914C-6E8058396909', N'shgfdskgf', NULL, CAST(N'2024-06-08T14:29:36.053' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'c820e417-516c-4cc7-ad25-90e4ee33dd22', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'4577FBEC-F3AB-4C4A-B9F0-A255D6ED0317', N'ABVCD19', NULL, CAST(N'2024-06-06T09:52:06.940' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'b4c43d34-b374-44c5-86c9-8b826b8a7957', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'5A50CA4E-F750-4819-97D7-9CCCD1659E56', N'string', NULL, CAST(N'2024-06-05T15:02:07.353' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'5191e102-8a38-4ecd-8649-717ea96cab37', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'83BA81FA-9E3E-4F84-8508-9184E99E416F', N'ggjaj', NULL, CAST(N'2024-06-08T14:34:36.480' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'b23fc216-803f-40dd-a05e-75f4c70bb836', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'84F3B12E-CCBB-4B48-B36B-1E0962A909C8', N'HÂFGA', NULL, CAST(N'2024-06-06T11:05:36.863' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'866c59cc-49d5-4103-af3f-2bb2bdd360f0', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'8F0DDBA2-30A3-4776-9E26-DD08F989DFB7', N'string', NULL, CAST(N'2024-06-05T15:19:12.953' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'16ed383d-2ba5-4776-a6dc-7b8f86ed3fc5', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'98BFE7D1-D2D1-4770-BA71-3A79403BC337', N'GJDGJA', NULL, CAST(N'2024-06-08T14:39:12.190' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'b386f100-4eb8-47cc-827e-bb6a60484f50', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'99149E6C-991C-4A81-9769-E79E9291D8FB', N'HÂFGA', NULL, CAST(N'2024-06-06T11:06:11.673' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ac46d7ee-869b-450b-943c-110f3e224391', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'A535D609-8601-41A6-814E-D3722A9A8CC3', N'thanhcong', NULL, CAST(N'2024-06-06T16:12:59.987' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'46d98642-dd2d-466d-a63c-1f279f60f758', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'AFD8397B-DA1A-4429-8D28-DC28F10F30AD', N'shgfdskgf', NULL, CAST(N'2024-06-08T14:27:09.800' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'd4bc5e1c-1adf-494a-b73c-84b4e154c305', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'B32C97B8-10E5-4644-BDE2-9F4577621F24', N'string', NULL, CAST(N'2024-06-05T15:10:20.880' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'9b65f4e2-5e23-473f-8c88-1f6112a80b01', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'CEB8C03D-A68B-4E57-A2E3-3BC60999B6CA', N'rdfsdg', NULL, CAST(N'2024-06-08T14:37:37.010' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'e87743ef-9c80-405e-8bd2-01341c032cbb', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'E0D40D03-8FC0-4F75-BC75-B01F9E599722', N'string', NULL, CAST(N'2024-06-06T09:44:04.390' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'35793c76-5b99-4a94-8999-03cb350ab54e', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'F94632FE-2F15-43E8-B34E-073737F4F082', N'string', NULL, CAST(N'2024-06-08T14:40:49.267' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'ea522690-7909-4363-8be1-c7cdadd22f86', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'FD58F7AB-E4B7-4C86-B489-C896376951C0', N'ADGSJ89', NULL, CAST(N'2024-06-06T13:02:15.223' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'08d72c61-53b1-403b-8bc2-b4f46fd3382e', 1)
INSERT [dbo].[PaymentSignature] ([Id], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'FD9CB5C3-1467-45B0-B2F6-821BAD232922', N'string', NULL, CAST(N'2024-06-05T11:48:19.610' AS DateTime), N'A8D6F4DA-87BB-4B41-87E2-21D7907D195D', N'2ef05fef-6b3b-4a9e-a761-637143ec9c79', 1)
GO
INSERT [HangFire].[Schema] ([Version]) VALUES (9)
GO
INSERT [HangFire].[Server] ([Id], [Data], [LastHeartbeat]) VALUES (N'laptop-ikqsb2pg:5788:a7c36ce9-e070-43d9-9791-2f14631a787d', N'{"WorkerCount":20,"Queues":["default"],"StartedAt":"2024-06-08T07:58:00.1630711Z"}', CAST(N'2024-06-08T08:30:31.503' AS DateTime))
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Merchant_MerchantId] FOREIGN KEY([MerchantId])
REFERENCES [dbo].[Merchant] ([Id])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Merchant_MerchantId]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_PaymentDestination_DesId] FOREIGN KEY([PaymentDestinationId])
REFERENCES [dbo].[PaymentDestination] ([id])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_PaymentDestination_DesId]
GO
ALTER TABLE [dbo].[PaymentDestination]  WITH CHECK ADD  CONSTRAINT [FK_PaymentDestination_PaymentDestination_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[PaymentDestination] ([id])
GO
ALTER TABLE [dbo].[PaymentDestination] CHECK CONSTRAINT [FK_PaymentDestination_PaymentDestination_ParentId]
GO
ALTER TABLE [dbo].[PaymentNotification]  WITH CHECK ADD  CONSTRAINT [FK_PaymentNotification_Merchant_MerchantId] FOREIGN KEY([MerchantId])
REFERENCES [dbo].[Merchant] ([Id])
GO
ALTER TABLE [dbo].[PaymentNotification] CHECK CONSTRAINT [FK_PaymentNotification_Merchant_MerchantId]
GO
ALTER TABLE [dbo].[PaymentNotification]  WITH CHECK ADD  CONSTRAINT [FK_PaymentNotification_Payment_PaymentId] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([Id])
GO
ALTER TABLE [dbo].[PaymentNotification] CHECK CONSTRAINT [FK_PaymentNotification_Payment_PaymentId]
GO
ALTER TABLE [dbo].[PaymentSignature]  WITH CHECK ADD  CONSTRAINT [FK_PaymentSignature_Payment_PaymentId] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([Id])
GO
ALTER TABLE [dbo].[PaymentSignature] CHECK CONSTRAINT [FK_PaymentSignature_Payment_PaymentId]
GO
ALTER TABLE [dbo].[PaymentTransaction]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransaction_Payment_PaymentId] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([Id])
GO
ALTER TABLE [dbo].[PaymentTransaction] CHECK CONSTRAINT [FK_PaymentTransaction_Payment_PaymentId]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
/****** Object:  StoredProcedure [dbo].[sproc_merchantDelete]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_merchantDelete]  
	-- Add the parameters for the stored procedure here
	@Id nvarchar(50) = ''
AS
BEGIN
	delete 
	from Merchant
	where Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantInsert]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantInsert]
	-- Add the parameters for the stored procedure here
	@Id nvarchar(50) = '',
	@MerchantName nvarchar(250) = '',
	@MerchantWebLink nvarchar(550) = '',
	@MerchantIpnUrl nvarchar(550) = '',
	@MerchantReturnUrl nvarchar(550) = '',
	@SecretKey nvarchar(250) = '',
	@IsActive bit = 0,
	@InsertUser nvarchar(50),
	@InsertedId nvarchar(50) Output
AS
BEGIN
	IF(@Id is null or trim(@Id) = '')
	begin
		set @Id = NEWID()
	end
	if(@SecretKey is null or trim(@SecretKey) = '')
	begin
		set @SecretKey = NEWID()
	end
	set @InsertedId = @Id
	INSERT INTO [dbo].[Merchant]
           ([Id]
           ,[MerchantName]
           ,[MerchantWebLink]
           ,[MerchantIpnUrl]
           ,[MerchantReturnUrl]
           ,[SecretKey]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedAt])
     VALUES
           (@Id
           ,@MerchantName
           ,@MerchantWebLink
           ,@MerchantIpnUrl
           ,@MerchantReturnUrl
           ,@SecretKey
           ,@IsActive
           ,@InsertUser
           ,GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantSelectByCriteria]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantSelectByCriteria] 
	-- Add the parameters for the stored procedure here
	@Criteria nvarchar(500) = ''
AS
BEGIN
	SELECT [Id]
      ,[MerchantName]
      ,[MerchantWebLink]
      ,[MerchantIpnUrl]
      ,[MerchantReturnUrl]
      ,[SecretKey]
      ,[IsActive]
      ,[CreatedBy]
      ,[LastUpdatedBy]
      ,[CreatedAt]
      ,[LastUpdatedAt]
  FROM [dbo].[Merchant](NOLOCK)
  WHERE 
	TRIM(@Criteria) = '' or @Criteria is null
	or MerchantName LIKE '%' + @Criteria + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantSelectByCriteriaPaging]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantSelectByCriteriaPaging]  
	-- Add the parameters for the stored procedure here
	@PageIndex int = 0,
	@PageSize int = 0,   
	@Criteria nvarchar(500) = '',
	@TotalPage int output,
	@TotalCount int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @Offset int = (@PageIndex - 1) * @PageSize
	SELECT [Id]
      ,[MerchantName]
      ,[MerchantWebLink]
      ,[MerchantIpnUrl]
      ,[MerchantReturnUrl]
      ,[SecretKey]
      ,[IsActive]
      ,[CreatedBy]
      ,[LastUpdatedBy]
      ,[CreatedAt]
      ,[LastUpdatedAt]
  FROM [dbo].[Merchant](NOLOCK)
  WHERE 
	TRIM(@Criteria) = '' or @Criteria is null
	or MerchantName LIKE '%' + @Criteria + '%'
  Order by Id
  Offset @Offset rows
  Fetch next @PageSize Rows only
  -- set totalCount
  SELECT @TotalCount = COUNT(Id)
  FROM [dbo].[Merchant](NOLOCK)
  WHERE 
	TRIM(@Criteria) = '' or @Criteria is null
	or MerchantName LIKE '%' + @Criteria + '%'
  -- set TotalPage
  set @TotalPage = CEILING(@TotalCount/CONVERT(float, @PageSize))
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantSelectById]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantSelectById] 
	@Id nvarchar(50) = ''	
AS
BEGIN
	SELECT [Id]
      ,[MerchantName]
      ,[MerchantWebLink]
      ,[MerchantIpnUrl]
      ,[MerchantReturnUrl]
      ,[SecretKey]
      ,[IsActive]
      ,[CreatedBy]
      ,[LastUpdatedBy]
      ,[CreatedAt]
      ,[LastUpdatedAt]
  FROM [dbo].[Merchant](NOLOCK)
  WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_merchantUpdate]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_merchantUpdate] 
	-- Add the parameters for the stored procedure here
	@Id nvarchar(50) = '',
	@MerchantName nvarchar(250) = '',
	@MerchantWebLink nvarchar(550) = '',
	@MerchantIpnUrl nvarchar(550) = '',
	@MerchantReturnUrl nvarchar(550) = '',
	@SecretKey nvarchar(250) = '',
	@IsActive bit = 0,
	@UpdateUser nvarchar(50)
AS
BEGIN
	UPDATE M
	set MerchantName = @MerchantName,
		MerchantWebLink = @MerchantWebLink,
		MerchantIpnUrl = @MerchantIpnUrl,
		MerchantReturnUrl = @MerchantReturnUrl,
		SecretKey = @SecretKey,
		IsActive = @IsActive,
		LastUpdatedBy = @UpdateUser,
		LastUpdatedAt = GETDATE()
	from Merchant M
	where Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_merchantUpdateActive]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_merchantUpdateActive] 
	-- Add the parameters for the stored procedure here
	@Id nvarchar(50) = '',
	@IsActive bit = 0,
	@UpdateUser nvarchar(50)	
AS
BEGIN
	UPDATE M
	set IsActive = @IsActive,
		LastUpdatedBy = @UpdateUser,
		LastUpdatedAt = GETDATE()
	from Merchant M
	where Id = @Id	
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_PaymentInsert]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sproc_PaymentInsert] 
	-- Add the parameters for the stored procedure here
	@Id nvarchar(50) = '',
	@PaymentContent nvarchar(250) = null,
	@PaymentCurrency nvarchar(10) = null,
	@PaymentRefId nvarchar(50) = null,
	@RequiredAmount decimal(19, 2) = null,
	@PaymentDate Datetime = null,
	@ExpireDate Datetime = null,
	@PaymentLanguage nvarchar(10) = null,
	@MerchantId nvarchar(50) = null,
	@PaymentDestinationId nvarchar(50) = null,
	@Signature nvarchar(100) = '',
	@InsertUser nvarchar(250) = '',
	@InsertedId nvarchar(50) output
AS
BEGIN
	if(@PaymentDate is null)
	begin
		set @PaymentDate = GETDATE()
	end
	if(@ExpireDate is null)
	begin
		set @ExpireDate = DATEADD(MINUTE, 15, GETDATE())
	end
	if(@Id is null)
	begin
		set @Id = NEWID()
	end
	INSERT INTO [dbo].[Payment]
           ([Id]
           ,[PaymentContent]
           ,[PaymentCurrency]
           ,[PaymentRefId]
           ,[RequiredAmount]
           ,[PaymentDate]
           ,[ExpireDate]
           ,[PaymentLanguage]
           ,[MerchantId]
           ,[PaymentDestinationId]
           ,[CreatedBy]
		   ,[CreatedAt])
     VALUES
           (@Id,
		   @PaymentContent,
		   @PaymentCurrency,
		   @PaymentRefId,
		   @RequiredAmount,
		   @PaymentDate,
		   @ExpireDate,
		   @PaymentLanguage,
		   @MerchantId,
		   @PaymentDestinationId,
		   @InsertUser,
		   GETDATE())

	 Set @InsertedId = @Id

	 INSERT INTO [dbo].[PaymentSignature]
           ([Id]
           ,[SignValue]
           ,[SignDate]
           ,[SignOwn]
           ,[PaymentId]
           ,[IsValid])
     VALUES
           (NEWID(),
		   @Signature,
		   GETDATE(),
		   @MerchantId,
		   @Id,
		   1)
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_PaymentSelectById]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_PaymentSelectById]
	-- Add the parameters for the stored procedure here
	@PaymentId nvarchar(50) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[PaymentContent]
      ,[PaymentCurrency]
      ,[PaymentRefId]
      ,[RequiredAmount]
      ,[PaymentDate]
      ,[ExpireDate]
      ,[PaymentLanguage]
      ,[MerchantId]
      ,[PaymentDestinationId]
      ,[PaidAmount]
      ,[PaymentStatus]
      ,[PaymentLastMessage]
      ,[CreatedBy]
      ,[CreatedAt]
      ,[LastUpdatedBy]
      ,[LastUpdatedAt]
  FROM [dbo].[Payment](NOLOCK)
  WHERE [Id] = @PaymentId
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_PaymentTransactionInsert]    Script Date: 6/10/2024 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_PaymentTransactionInsert] 
	-- Add the parameters for the stored procedure here
	@Id nvarchar(50) = '',
	@TranMessage nvarchar(250) = '',
	@TranPayload nvarchar(500) = '',
	@TranStatus nvarchar(10) = '',
	@TranAmount decimal(19, 2) null,
	@TranDate datetime null,
	@PaymentId nvarchar(50) = '',
	@InsertUser nvarchar(50) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @TranDate IS NULL
	begin
		Set @TranDate = GETDATE()
	end
	Begin Transaction CreatePaymentTransaction
	begin try
		INSERT INTO [dbo].[PaymentTransaction]
           ([Id]
           ,[TranMessage]
           ,[TranPayload]
           ,[TranStatus]
           ,[TranAmount]
           ,[TranDate]
           ,[PaymentId]
           ,[CreatedBy]
           ,[CreatedAt])
		VALUES
           (@Id,
		   @TranMessage,
		   @TranPayload,
		   @TranStatus,
		   @TranAmount,
		   @TranDate,
		   @PaymentId,
		   @InsertUser,
		   GETDATE())
		Update p
		set p.PaidAmount = t.PaidAmount,
			p.PaymentLastMessage = @TranMessage,
			p.PaymentStatus = @TranStatus,
			p.LastUpdatedAt = GETDATE(),
			p.LastUpdatedBy = @InsertUser
		from Payment p
			Join
			(
				select 
					paymentId,
					SUM(TranAmount) as PaidAmount
				from PaymentTransaction
				where PaymentId = @PaymentId
					and TranStatus = '0'
				group by PaymentId
			) t on p.Id = t.paymentId
		commit transaction CreatePaymentTransaction
	end try
	begin catch
		rollback transaction CreatePaymentTransaction
	end catch
END
GO
