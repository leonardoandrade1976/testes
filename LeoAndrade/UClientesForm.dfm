object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes - Teste - Leonardo de Castro Andrade'
  ClientHeight = 287
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 27
    Height = 13
    Caption = 'Nome'
    FocusControl = edtNome
  end
  object Label2: TLabel
    Left = 244
    Top = 12
    Width = 52
    Height = 13
    Caption = 'Identidade'
    FocusControl = edtIdentidade
  end
  object Label3: TLabel
    Left = 376
    Top = 12
    Width = 19
    Height = 13
    Caption = 'CPF'
    FocusControl = edtCpf
  end
  object Label4: TLabel
    Left = 8
    Top = 56
    Width = 42
    Height = 13
    Caption = 'Telefone'
    FocusControl = edtTelefone
  end
  object Label5: TLabel
    Left = 79
    Top = 56
    Width = 28
    Height = 13
    Caption = 'E-mail'
    FocusControl = edtEmail
  end
  object edtNome: TEdit
    Left = 8
    Top = 28
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object edtIdentidade: TEdit
    Left = 244
    Top = 28
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtCpf: TEdit
    Left = 376
    Top = 28
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtTelefone: TEdit
    Left = 8
    Top = 72
    Width = 65
    Height = 21
    TabOrder = 3
  end
  object edtEmail: TEdit
    Left = 79
    Top = 72
    Width = 418
    Height = 21
    CharCase = ecLowerCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 100
    Width = 485
    Height = 145
    Caption = 'Endere'#231'o'
    TabOrder = 5
    object Label6: TLabel
      Left = 8
      Top = 20
      Width = 19
      Height = 13
      Caption = 'CEP'
      FocusControl = edtCEP
    end
    object Label7: TLabel
      Left = 79
      Top = 20
      Width = 55
      Height = 13
      Caption = 'Logradouro'
      FocusControl = edtLogradouro
    end
    object Label8: TLabel
      Left = 7
      Top = 60
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
      FocusControl = edtNumero
    end
    object Label9: TLabel
      Left = 78
      Top = 60
      Width = 65
      Height = 13
      Caption = 'Complemento'
      FocusControl = edtComplemento
    end
    object Label10: TLabel
      Left = 203
      Top = 60
      Width = 28
      Height = 13
      Caption = 'Bairro'
      FocusControl = edtBairro
    end
    object Label11: TLabel
      Left = 7
      Top = 100
      Width = 33
      Height = 13
      Caption = 'Cidade'
      FocusControl = edtCidade
    end
    object Label12: TLabel
      Left = 203
      Top = 100
      Width = 33
      Height = 13
      Caption = 'Estado'
      FocusControl = edtUF
    end
    object Label13: TLabel
      Left = 242
      Top = 100
      Width = 19
      Height = 13
      Caption = 'Pa'#237's'
      FocusControl = edtPais
    end
    object edtCEP: TEdit
      Left = 8
      Top = 36
      Width = 65
      Height = 21
      TabOrder = 0
      OnExit = edtCEPExit
    end
    object edtLogradouro: TEdit
      Left = 79
      Top = 36
      Width = 398
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtNumero: TEdit
      Left = 7
      Top = 76
      Width = 65
      Height = 21
      TabOrder = 2
    end
    object edtComplemento: TEdit
      Left = 78
      Top = 76
      Width = 119
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtBairro: TEdit
      Left = 203
      Top = 76
      Width = 274
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edtCidade: TEdit
      Left = 7
      Top = 116
      Width = 190
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edtUF: TEdit
      Left = 203
      Top = 116
      Width = 33
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object edtPais: TEdit
      Left = 242
      Top = 116
      Width = 235
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
  end
  object Enviar: TButton
    Left = 422
    Top = 254
    Width = 75
    Height = 25
    Caption = 'Enviar'
    TabOrder = 6
    OnClick = EnviarClick
  end
  object IdSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 199
    Top = 32
  end
  object IdSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 380
    Top = 48
  end
end
