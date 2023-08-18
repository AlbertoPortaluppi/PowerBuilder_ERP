HA$PBExportHeader$w_ancestor_cadastro.srw
forward
global type w_ancestor_cadastro from w_ancestor
end type
type cb_incluir from u_commandbutton within w_ancestor_cadastro
end type
type dw_filtros from datawindow within w_ancestor_cadastro
end type
type cb_limparfiltros from u_commandbutton within w_ancestor_cadastro
end type
type cb_pesquisar from u_commandbutton within w_ancestor_cadastro
end type
type dw_corrente from datawindow within w_ancestor_cadastro
end type
type cb_voltar from u_commandbutton within w_ancestor_cadastro
end type
type cb_gravar from u_commandbutton within w_ancestor_cadastro
end type
type gb_1 from groupbox within w_ancestor_cadastro
end type
type gb_2 from groupbox within w_ancestor_cadastro
end type
end forward

global type w_ancestor_cadastro from w_ancestor
integer width = 6295
integer height = 3236
string title = ""
cb_incluir cb_incluir
dw_filtros dw_filtros
cb_limparfiltros cb_limparfiltros
cb_pesquisar cb_pesquisar
dw_corrente dw_corrente
cb_voltar cb_voltar
cb_gravar cb_gravar
gb_1 gb_1
gb_2 gb_2
end type
global w_ancestor_cadastro w_ancestor_cadastro

forward prototypes
public subroutine of_gravar ()
public subroutine of_voltar ()
public subroutine of_limparfiltros ()
public subroutine of_incluir ()
public function integer of_pesquisar ()
public subroutine of_validar_exclusao ()
public function integer of_validar_inclusao ()
end prototypes

public subroutine of_gravar ();//
end subroutine

public subroutine of_voltar ();Close(This)
end subroutine

public subroutine of_limparfiltros ();dw_Filtros.Reset()
dw_Filtros.InsertRow(0)
end subroutine

public subroutine of_incluir ();Long ll_Row
ll_Row = dw_Corrente.InsertRow(0)
dw_Corrente.SetItem(ll_Row, 'FLAGINATIVO', 'F')
end subroutine

public function integer of_pesquisar ();dw_Corrente.SetTransObject(SQLCA)

Return 1
end function

public subroutine of_validar_exclusao ();Long ll_For, ll_Find
dw_Corrente.AcceptText()

ll_Find = dw_Corrente.Find("flag = 'T'", 1, dw_Corrente.RowCount())
If ll_Find > 0 Then
	For ll_For = dw_Corrente.RowCount() To 0 Step -1
		If dw_Corrente.GetItemString(ll_For, 'flag') = 'T' Then
			dw_Corrente.RowsMove(ll_For, ll_For, Primary!, dw_Corrente, dw_Corrente.DeletedCount() + 1, Delete!)
		End If
	Next
End If
end subroutine

public function integer of_validar_inclusao ();Return -1
end function

on w_ancestor_cadastro.create
int iCurrent
call super::create
this.cb_incluir=create cb_incluir
this.dw_filtros=create dw_filtros
this.cb_limparfiltros=create cb_limparfiltros
this.cb_pesquisar=create cb_pesquisar
this.dw_corrente=create dw_corrente
this.cb_voltar=create cb_voltar
this.cb_gravar=create cb_gravar
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_incluir
this.Control[iCurrent+2]=this.dw_filtros
this.Control[iCurrent+3]=this.cb_limparfiltros
this.Control[iCurrent+4]=this.cb_pesquisar
this.Control[iCurrent+5]=this.dw_corrente
this.Control[iCurrent+6]=this.cb_voltar
this.Control[iCurrent+7]=this.cb_gravar
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_ancestor_cadastro.destroy
call super::destroy
destroy(this.cb_incluir)
destroy(this.dw_filtros)
destroy(this.cb_limparfiltros)
destroy(this.cb_pesquisar)
destroy(this.dw_corrente)
destroy(this.cb_voltar)
destroy(this.cb_gravar)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_Filtros.SetTransObject(SQLCA)
dw_Filtros.InsertRow(0)

dw_Corrente.SetTransObject(SQLCA)
end event

type cb_incluir from u_commandbutton within w_ancestor_cadastro
integer x = 123
integer y = 3024
integer width = 768
integer taborder = 20
boolean enabled = false
string text = "Incluir"
end type

event clicked;call super::clicked;of_Incluir()
end event

type dw_filtros from datawindow within w_ancestor_cadastro
integer x = 146
integer y = 84
integer width = 5417
integer height = 360
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_limparfiltros from u_commandbutton within w_ancestor_cadastro
integer x = 5623
integer y = 88
integer width = 581
integer taborder = 20
string text = "Limpar filtros"
end type

event clicked;call super::clicked;of_LimparFiltros()
end event

type cb_pesquisar from u_commandbutton within w_ancestor_cadastro
integer x = 5623
integer y = 328
integer width = 581
integer taborder = 20
string text = "Pesquisar"
end type

event clicked;call super::clicked;If of_Pesquisar() > 0 Then
	cb_Incluir.Enabled = True
	cb_gravar.Enabled = True
Else
	Msg('Erro ao carregar informa$$HEX2$$e700f500$$ENDHEX$$es!')
End If
end event

type dw_corrente from datawindow within w_ancestor_cadastro
integer x = 123
integer y = 576
integer width = 6080
integer height = 2372
integer taborder = 10
string title = "none"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;Selectrow(0,false)
end event

type cb_voltar from u_commandbutton within w_ancestor_cadastro
integer x = 5490
integer y = 3024
integer width = 768
integer taborder = 10
string text = "Voltar"
end type

event clicked;call super::clicked;of_Voltar()
end event

type cb_gravar from u_commandbutton within w_ancestor_cadastro
integer x = 4603
integer y = 3024
integer width = 768
integer taborder = 10
boolean enabled = false
string text = "Gravar"
end type

event clicked;call super::clicked;If of_Validar_Inclusao() = 1 Then
	dw_Corrente.SetRedraw(False)
	dw_Corrente.SetFilter('')
	dw_Corrente.Filter()
	
	of_Validar_Exclusao()
	of_Gravar()
	
	dw_Corrente.SetRedraw(True)
End If
end event

type gb_1 from groupbox within w_ancestor_cadastro
integer x = 64
integer y = 488
integer width = 6194
integer height = 2520
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pesquisa"
end type

type gb_2 from groupbox within w_ancestor_cadastro
integer x = 64
integer y = 12
integer width = 6194
integer height = 476
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtros"
end type
