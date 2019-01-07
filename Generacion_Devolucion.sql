--alter table ##temp_OrdenTrabajo add strTipoDocumentoReferencia varchar(5)
--alter table ##temp_OrdenTrabajo add strNumeroSerieReferencia varchar(5)
--alter table ##temp_OrdenTrabajo add strNumeroDocumentoReferencia varchar(20)
--alter table ##temp_OrdenTrabajo add datFecEmiOrigen varchar(23)
--alter table ##temp_OrdenTrabajo add datFecEmiOrigen varchar(23)
--alter table ##temp_OrdenTrabajo add strNumeroDevolucion varchar(50)
DECLARE @NUMERO_INICIAL_DEV bigint=0
select @NUMERO_INICIAL_DEV = Cast(REPLACE(NUMERO_DEVOLUCION,'R','') as bigint)   From EADD.DEVOLUCION where CORRELATIVO_DEVOLUCION in (
select max(CORRELATIVO_DEVOLUCION)  From EADD.DEVOLUCION where NUMERO_DEVOLUCION like 'R%')


--SELECT RIGHT('000000000'+CAST(REPLACE(NUMERO_DEVOLUCION,'R','') AS VARCHAR(9)),9)

update t set strTipoDocumentoReferencia = TIPO_DOCUMENTO,
strNumeroSerieReferencia = SERIE_DOCUMENTO,
strNumeroDocumentoReferencia = NUMERO_DOCUMENTO,
datFecEmiOrigen =   CONVERT(VARCHAR(23), FECHA_EMISION, 126),
strNumeroDevolucion  ='R'+RIGHT('000000000'+ CAST((@NUMERO_INICIAL_DEV + ID) as varchar(9)) ,9)
from ##temp_OrdenTrabajo t
inner join EADD.DOCUMENTO_LEGAL dl on t.strNumOrden = dl.NUMERO_TRANSACCION_COMERCIAL and dl.TIPO_EMISION = 'E'
inner join EADD.DOCUMENTO_LEGAL_EMISION DLE on dl.CORRELATIVO_DOCUMENTO_LEGAL = dle.CORRELATIVO_DOCUMENTO_LEGAL


select * From ##temp_OrdenTrabajo

