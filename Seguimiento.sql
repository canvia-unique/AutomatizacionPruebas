/*--------------------------------------------------------------------------------------------------------*/
/*****************************Seguimiento de Ordenes*****************************************************/
/*--------------------------------------------------------------------------------------------------------*/
select strNumOrden CP_ORDEN,strTipOrden CP_TIPO_ORDEN,strTipoPersona CP_TIPO_PERSONA,dl.TIPO_EMISION TP_EMISION,dl.TIPO_DOCUMENTO TP_DOCUMENTO,dle.ESTADO_DOCUMENTO,dlem.SERIE_DOCUMENTO,
dlem.NUMERO_DOCUMENTO,dle.ESTADO_CERTIFICADORA from ##temp_OrdenTrabajo t
left join EADD.DOCUMENTO_LEGAL dl 
on cast(t.strNumOrden  as varchar(20)) = dl.NUMERO_TRANSACCION_COMERCIAL AND DL.TIPO_TRANSACCION != 'ABO' and  dl.TIPO_EMISION = 'E'
left join EADD.DOCUMENTO_LEGAL_ESTADO dle
on dle.CORRELATIVO_DOCUMENTO_LEGAL = dl.CORRELATIVO_DOCUMENTO_LEGAL
left join EADD.DOCUMENTO_LEGAL_EMISION dlem 
on dlem.CORRELATIVO_DOCUMENTO_LEGAL = dle.CORRELATIVO_DOCUMENTO_LEGAL
where isnull(dl.TIPO_TRANSACCION,'') not in ('SER','GIM')
order by dlem.NUMERO_DOCUMENTO

select * from EADD.PARAMETROS where codigo_tabla = 0
/*--------------------------------------------------------------------------------------------------------*/
/******************************Seguimiento de Devoluciones******************************************************/
/*--------------------------------------------------------------------------------------------------------*/
	select dle.ESTADO_DOCUMENTO,dlem.NUMERO_DOCUMENTO,DL.CORRELATIVO_DOCUMENTO_LEGAL,strNumOrden,strNumeroDevolucion,strTipOrden,strTipoPersona,dl.TIPO_DOCUMENTO,dle.ESTADO_DOCUMENTO,dle.ESTADO_CERTIFICADORA,dlem.SERIE_DOCUMENTO,
	dlem.NUMERO_DOCUMENTO,* from ##temp_OrdenTrabajo t
	left join EADD.DOCUMENTO_LEGAL dl 
	on cast(t.strNumeroDevolucion  as varchar(20)) = dl.NUMERO_TRANSACCION_COMERCIAL
	left join EADD.DOCUMENTO_LEGAL_ESTADO dle
	on dle.CORRELATIVO_DOCUMENTO_LEGAL = dl.CORRELATIVO_DOCUMENTO_LEGAL
	left join EADD.DOCUMENTO_LEGAL_EMISION dlem 
	on dlem.CORRELATIVO_DOCUMENTO_LEGAL = dle.CORRELATIVO_DOCUMENTO_LEGAL
	--where dle.ESTADO_DOCUMENTO = 6
	order by dlem.NUMERO_DOCUMENTO
/*--------------------------------------------------------------------------------------------------------*/
/******************************************************Seguimiento de Abono******************************************************/
/*--------------------------------------------------------------------------------------------------------*/
select dle.CORRELATIVO_DOCUMENTO_LEGAL,dl.TIPO_TRANSACCION,dle.ESTADO_DOCUMENTO,dlem.SERIE_DOCUMENTO,dlem.NUMERO_DOCUMENTO,dlem.FECHA_EMISION from EADD.DOCUMENTO_LEGAL dl inner JOIN
EADD.DOCUMENTO_LEGAL_ESTADO dle on dl.CORRELATIVO_DOCUMENTO_LEGAL = dle.CORRELATIVO_DOCUMENTO_LEGAL
LEFT JOIN EADD.DOCUMENTO_LEGAL_EMISION dlem on dl.CORRELATIVO_DOCUMENTO_LEGAL = dlem.CORRELATIVO_DOCUMENTO_LEGAL
LEFT JOIN EADD.ABONO A on dl.CORRELATIVO_TRANSACCION = A.CORRELATIVO_ABONO
INNER JOIN  ##temp_OrdenTrabajo T on A.NUMERO_ORDEN = cast(t.strNumOrden  as varchar(20))
WHERE dl.TIPO_TRANSACCION = 'ABO'
order by dlem.NUMERO_DOCUMENTO
/*--------------------------------------------------------------------------------------------------------*/
/******************************************************Seguimiento de Nota Debito******************************************************/
/*--------------------------------------------------------------------------------------------------------*/

select dle.CORRELATIVO_DOCUMENTO_LEGAL,dl.TIPO_TRANSACCION,dle.ESTADO_DOCUMENTO,dlem.SERIE_DOCUMENTO,dlem.NUMERO_DOCUMENTO,dlem.FECHA_EMISION from EADD.DOCUMENTO_LEGAL dl inner JOIN
EADD.DOCUMENTO_LEGAL_ESTADO dle on dl.CORRELATIVO_DOCUMENTO_LEGAL = dle.CORRELATIVO_DOCUMENTO_LEGAL
LEFT JOIN EADD.DOCUMENTO_LEGAL_EMISION dlem on dl.CORRELATIVO_DOCUMENTO_LEGAL = dlem.CORRELATIVO_DOCUMENTO_LEGAL
LEFT JOIN EADD.NOTA_DEBITO A on dl.CORRELATIVO_TRANSACCION = A.CORRELATIVO_NOTA_DEBITO
INNER JOIN  ##temp_OrdenTrabajo T on A.NUMERO_ORDEN = cast(t.strNumOrden  as varchar(20))
WHERE dl.TIPO_TRANSACCION = 'NDEB'
order by dlem.NUMERO_DOCUMENTO
/*--------------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------*/
select dle.CORRELATIVO_DOCUMENTO_LEGAL,dl.TIPO_TRANSACCION,dle.ESTADO_DOCUMENTO,dlem.SERIE_DOCUMENTO,dlem.NUMERO_DOCUMENTO  From EADD.DOCUMENTO_LEGAL dl
inner join EADD.DOCUMENTO_LEGAL_ESTADO dle 
on dl.CORRELATIVO_DOCUMENTO_LEGAL = dle.CORRELATIVO_DOCUMENTO_LEGAL
inner join EADD.DOCUMENTO_LEGAL_EMISION dlem ON
dl.CORRELATIVO_DOCUMENTO_LEGAL = dlem.CORRELATIVO_DOCUMENTO_LEGAL
 where CORRELATIVO_TRANSACCION  IN
(
'11575859'
) and TIPO_TRANSACCION = 'CPER'



select top 100 * from EADD.LOG_ADD 
where CORRELATIVO_LOG > 1872572
order by  1 desc

