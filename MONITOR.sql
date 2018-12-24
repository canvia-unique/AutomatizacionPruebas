IF OBJECT_ID('tempdb..#tmpReporte', 'U') IS NOT NULL
drop TABLE #tmpReporte

select DLL.CORRELATIVO_DOCUMENTO_LEGAL_LOTE IDLOTE,DLL.ESTADO_LOTE_PAPERLESS STDPAPER,DLL.ESTADO_LOTE_EMISION STDEMI,
DLL.CANTIDAD_DOCUMENTO CANTDOCS ,DL.TIPO_EMISION,
SUM(IIF(DLE.ESTADO_DOCUMENTO = 1, 1,0)) CantidadGenerado,
SUM(IIF(DLE.ESTADO_DOCUMENTO = 2, 1,0)) CantidadPorEmitir,
SUM(IIF(DLE.ESTADO_DOCUMENTO = 3, 1,0)) CantidadEmitiendo,
SUM(IIF(DLE.ESTADO_DOCUMENTO > 3, 1,0)) CantidadImpreso into #tmpReporte from EADD.DOCUMENTO_LEGAL_LOTE DLL WITH(NOLOCK)
INNER JOIN EADD.DOCUMENTO_LEGAL DL WITH(NOLOCK)
ON DLL.CORRELATIVO_DOCUMENTO_LEGAL_LOTE = DL.CORRELATIVO_DOCUMENTO_LEGAL_LOTE
INNER JOIN EADD.DOCUMENTO_LEGAL_ESTADO DLE WITH(NOLOCK)
ON DLE.CORRELATIVO_DOCUMENTO_LEGAL = DL.CORRELATIVO_DOCUMENTO_LEGAL
WHERE  CONVERT(VARCHAR,DLL.FECHA_CREACION,103) BETWEEN '12/12/2018' and '13/12/2018'
GROUP BY DLL.CORRELATIVO_DOCUMENTO_LEGAL_LOTE,DLL.ESTADO_LOTE_PAPERLESS,DLL.ESTADO_LOTE_EMISION,DLL.CANTIDAD_DOCUMENTO,DL.TIPO_EMISION
ORDER BY DLL.CORRELATIVO_DOCUMENTO_LEGAL_LOTE ASC


select * from #tmpReporte
where CantidadPorEmitir > 0	


--select  estado_lote_emision,estado_lote_paperless,*From eadd.documento_legal_lote where  correlativo_documento_legal_lote = 28225

--select dle.estado_documento,*FROM eadd.documento_legal dl with(nolock)
--inner join eadd.documento_legal_estado dle with(nolock)
--on dl.correlativo_documento_legal = dle.correlativo_documento_legal
-- where correlativo_documento_legal_lote = 28225


