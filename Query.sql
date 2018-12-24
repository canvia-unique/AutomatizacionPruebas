IF OBJECT_ID('tempdb..#TMP_JMETER_TEST01', 'U') IS NOT NULL
DROP TABLE #TMP_JMETER_TEST01

IF OBJECT_ID('tempdb..##temp_OrdenTrabajo', 'U') IS NOT NULL
DROP TABLE ##temp_OrdenTrabajo

IF OBJECT_ID('tempdb..##temp_OrdenTrabajo_Detalle', 'U') IS NOT NULL
DROP TABLE ##temp_OrdenTrabajo_Detalle

IF OBJECT_ID('tempdb..##temp_OrdenTrabajo_Detalle_Incentivo', 'U') IS NOT NULL
DROP TABLE ##temp_OrdenTrabajo_Detalle_Incentivo

IF OBJECT_ID('tempdb..#tmpResult', 'U') IS NOT NULL
DROP TABLE #tmpResult

IF OBJECT_ID('tempdb..##temp_PickingCabecera', 'U') IS NOT NULL
DROP TABLE ##temp_PickingCabecera

IF OBJECT_ID('tempdb..##temp_PickingDetalle', 'U') IS NOT NULL
DROP TABLE ##temp_PickingDetalle

IF OBJECT_ID('tempdb..##temp_Despacho', 'U') IS NOT NULL
DROP TABLE ##temp_Despacho

DECLARE @ITERACION AS VARCHAR(3);
SET @ITERACION = '100'

SELECT TOP 1000 
		CORRELATIVO_ORDEN, NUMERO_ORDEN
	INTO #TMP_JMETER_TEST01
FROM EADD.ORDEN O WITH(NOLOCK)
WHERE O.TIPO_ORDEN = 'NOR' ORDER BY NEWID()

--
SELECT '--ORDEN'
SELECT TOP 1000 
        RANK() OVER (ORDER BY CORRELATIVO_ORDEN ) AS  ID,
		CORRELATIVO_ORDEN,
		CONCAT(@ITERACION, NUMERO_ORDEN) strNumOrden,
		CODIGO_DIRECTORA strCodigoDirectora,
		CODIGO_CONSULTORA strCodigoConsultora,
		APELLIDO_PATERNO_CONSULTORA strApellidopaternoConsultora,
		APELLIDO_MATERNO_CONSULTORA strApellidomaternoConsultora,
		NOMBRE_CONSULTORA strNombreConsultora,
		TIPO_ORDEN strTipOrden,
		DESCRIPCION_TIPO strDescripciontipoOrden,
		UNIDAD_NEGOCIO strNombrePais,
		ANHO intAnho,
		CAMPANHA intCampanha,
		SEMANA intSemana,
		SEMANA_ANUAL intSemanaAnual,
		  CONVERT(VARCHAR(23), FECHA_INGRESO, 126) datFechaIngreso,
		USUARIO strUsuario,
		DIRECCION_ENTREGA strDireccionEnvio,
		NIVEL_GEOGRAFICO_1 strUbicacionGeograficaNivel1Consultora,
		NIVEL_GEOGRAFICO_2 strUbicacionGeograficaNivel2Consultora,
		NIVEL_GEOGRAFICO_3 strUbicacionGeograficaNivel3Consultora,
		CODIGO_POSTAL strCodigoPostal,
		CODIGO_ZONA strCodigoZona,
		VENTA_PUBLICA decMontoventapublicaTotal,
		VENTA_NETA decMontoventaNeta,
		VENTA_TOTAL_NETA decMontoventanetaTotal,
		IMPUESTO decMontoImpuesto,
		FLETE decMontoFlete,
		DESCUENTO_TOTAL decMontototalDescuento,
		TOTAL_ORDEN decMontoTotalOrden,
		ESCALA_DECUENTO decEscalaDescuento,
		CODIGO_ALMACEN cadCodigoAlmacen,
		INDICADOR_PRIMER_PEDIDO intIndicadorprimerPedido,
		GANANCIA_INTEGRAL decGananciaIntegral,
		PORCENTAJE_IMPUESTO_ADICIONAL decPorcentajeImpuestoAdicional,
		IMPUESTO_ADICIONAL decMontoImpuestosEspeciales,
		IMPUESTO_FLETE decMontoImpuestoFlete,
		PORCENTAJE_IMPUESTO decPorcentajeImpuesto,
		TIPO_PERSONA strTipoPersona,
		NUMERO_CONTRIBUYENTE strCodigoTributario,
		RAZON_SOCIAL strRazonSocial,
		DIRECCION_RAZON_SOCIAL strDireccionrazonSocial,
		EMAIL_CONSULTORA strCorreoConsultora,
		TELEFONO_CONSULTORA strTelefonoConsultora,
		DOCUMENTO_CONSULTORA strDocumentoidentidadConsultora,
		NOMBRE_DIRECTORA strNombreDirectora,
		DIRECCION_DIRECTORA strDireccionDirectora,
		TELEFONO_DIRECTORA strTelefonoDirectora,
		MONTO_APLICADO_ESTRELLA decMontoAplicadoEstrella,
		NUMERO_ORDEN_REFERENCIA strNumPedRef,
		TIPO_DOCUMENTO_REFERENCIA strTipDocRef,
		NUMERO_SERIE_REFERENCIA strNumSerRef,
		NUMERO_DOCUMENTO_REFERENCIA strNumDocRef,
		DESCRIPCION_RAZON_ORDEN strMtvOrdCompra,
		'' strDescMtvSalAdministrativa,
		CONVERT(VARCHAR(23), FECHA_EMISION_DOCUMENTO_REFERENCIA, 126) datfecEmiOrigen,
		TIPO_DOCUMENTO_IDENTIDAD strTipoDocumentoIdentidad, 
		DIRECCION_DOMICILIO strDireccionDomicilio,
		NIVEL_GEOGRAFICO_DOMICILIO_1 strNivelGeograficoDomicilio1,
		NIVEL_GEOGRAFICO_DOMICILIO_2 strNivelGeograficoDomicilio2,
		NIVEL_GEOGRAFICO_DOMICILIO_3 strNivelGeograficoDomicilio3,
		0 FlagIncentivo
		into ##temp_OrdenTrabajo
FROM EADD.ORDEN O WITH(NOLOCK)
WHERE O.CORRELATIVO_ORDEN IN (SELECT CORRELATIVO_ORDEN FROM #TMP_JMETER_TEST01)

SELECT 
	SECUENCIAL intNumeroSecuencial,
	CONCAT(@ITERACION, NUMERO_ORDEN) intNumeroOrden,
	CODIGO_PRODUCTO strCodigoProducto,
	DESCRIPCION_PRODUCTO strDescripcionProducto,
	CODIGO_OFERTA_PRODUCTO strCodigoComercial,
	CANTIDAD intCantidadProducto,
	TIPO_PRECIO_PRODUCTO strTipoPrecioProducto,
	PRECIO_UNITARIO decPrecioUnitarioProducto,
	PRECIO_REFERENCIAL decPrecioReferencial,
	NETO_PRODUCTO decMontoTotalProductoNeto,
	IMPUESTO_PRODUCTO decMontoTotalImpuestoProducto,
	IMPUESTO_OTROS_PRODUCTO decMontoTotalImpuestoAdicionalProducto,
	COMISIONABLE_OFERTA_PRODUCTO decMontoComisionableOfertaProducto,
	CLASE_OFERTA strClaseOferta,
	CODIGO_ORIGEN_ANUNCIO strOrigenAnuncio,
	TOTAL_DESCUENTO_PRODUCTO decMontoDescuentoProducto,
	CODIGO_RESPONSABLE strResponsable,
	CODIGO_ALMACEN strCodigoAlmacen,
	CODIGO_INCENTIVO strCodigoIncentivo,
	DESCRIPCION_COMERCIL_PRODUCTO strDescripcionComercial,
	PORCENTAJE_DESCUENTO_PRODUCTO decEscalaDescuento,
	CALIFICACION_TOTAL_PRODUCTO decMontoCalificacionProducto,
	MONTO_DESCUENTO_ESTRELLA decMontoDescuentoEstrella,
	CODIGO_PLAN_INCENTIVO strPlan,
	TIPO_CARRO strTipoCarro,
	ESTADO_PREMIO strFlagPremio,
	CODIGO_UNSPSC strCodigoUNSPSC
	into ##temp_OrdenTrabajo_Detalle
FROM EADD.ORDEN_DETALLE OD WITH(NOLOCK)
WHERE OD.CORRELATIVO_ORDEN IN (SELECT CORRELATIVO_ORDEN FROM #TMP_JMETER_TEST01)


SELECT 
	CORRELATIVO_ORDEN,
	SECUENCIAL intNumeroSecuencial,
	CODIGO_PLAN strPlanID,
	NOMBRE_PLAN strNombrePlan,
	DESCRIPCION_PLAN strDescripcionPlan,
	NIVEL_PLAN strNivelPlan,
	CODIGO_INCENTIVO strCodigoIncentivo,
	CODIGO_ORIGEN_INCENTIVO strCodigoOrigen,
	INICIAL_VENTA_INCENTIVO decMontoInicialincentivo,
	FINAL_VENTA_INCENTIVO decMontoFinalIncentivo,
	FECHA_INICIO_PLAN datFechaInicioPlan,
	FECHA_FIN_PLAN datFechaFinPlan,
	CODIGO_PRODUCTO strCodigoProducto,
	DESCRIPCION_PRODUCTO strDescripcionProducto,
	CODIGO_COMERCIAL_PRODUCTO strCodigoComercial,
	CANTIDAD intCantidadProducto,
	TIPO_PRECIO strTipoPrecioProducto,
	PRECIO_UNITARIO decPrecioUnitarioProducto,
	PRECIO_REFRENCIAL decPrecioReferencial,
	MARCA_PEDIDO strMarcaPedido into ##temp_OrdenTrabajo_Detalle_Incentivo
FROM EADD.ORDEN_DETALLE_INCENTIVO ODI WITH(NOLOCK)
WHERE ODI.CORRELATIVO_ORDEN IN (SELECT CORRELATIVO_ORDEN FROM #TMP_JMETER_TEST01)

SELECT  OT.CORRELATIVO_ORDEN, COUNT(1) CantidadIncentivo into #tmpResult FROM ##temp_OrdenTrabajo OT INNER JOIN ##temp_OrdenTrabajo_Detalle_Incentivo OTI
on OT.CORRELATIVO_ORDEN = OTI.CORRELATIVO_ORDEN
group by OT.CORRELATIVO_ORDEN




UPDATE OT set OT.flagIncentivo = case when TR.CantidadIncentivo > 0 then 1 else 0 end from ##temp_OrdenTrabajo OT inner join #tmpResult TR
on OT.CORRELATIVO_ORDEN = TR.CORRELATIVO_ORDEN

SELECT '--PICKING'

SELECT 
	CORRELATIVO_PICKING,
	UNIDAD_NEGOCIO strCodigoUnidadNegocio,
	CONCAT(@ITERACION, NUMERO_ORDEN) strNumeroOrdenCompra,
	FECHA_ENVIO datFechaEnvio,
	NUMERO_CAJAS intNumeroCajasOrden
	into ##temp_PickingCabecera
FROM EADD.PICKING_CABECERA PC WITH(NOLOCK)
WHERE PC.NUMERO_ORDEN IN (SELECT NUMERO_ORDEN FROM #TMP_JMETER_TEST01)


SELECT 
	CORRELATIVO_PICKING,
	SECUENCIA_ITEM intSecuenciaItem,
	CODIGO_ITEM strCodigoItem,
	CANTIDAD_PREPARADA intCantidadPreparada,
	MARCA_FUERA_CAJA strMarcaProductoFueraCaja,
	NUMERO_LOTE strNumeroLote,
	NOMBRE_PREMIO strNombreResumidoPremioFueraCaja,
	PUERTA_DESPACHO strPuertaDespacho,
	PESO_PRODUCTO decPesoProducto
	into ##temp_PickingDetalle
FROM EADD.PICKING_DETALLE PD WITH(NOLOCK)
WHERE PD.CORRELATIVO_PICKING IN (
									SELECT 
										CORRELATIVO_PICKING
									FROM EADD.PICKING_CABECERA PC WITH(NOLOCK)
									WHERE PC.NUMERO_ORDEN IN (SELECT NUMERO_ORDEN FROM #TMP_JMETER_TEST01)
								)

SELECT '--DESPACHO'

SELECT 
	UNIDAD_NEGOCIO strCodigoUnidadNegocio,
	CONCAT(@ITERACION, NUMERO_ORDEN) strNumeroOrdenCompra,
	NUMERO_PALLET strNumeroPallet,
	USUARIO strUsuario,
	NUMERO_DESPACHO strNumeroDespacho,
	FECHA_INICIO_TRASLADO datFechaInicioTraslado,
	RAZON_SOCIAL_1 strRazonSocialTransportista1,
	DIRECCION_1 strDireccionTransportista1,
	RUC_1 strRucTransportista1,
	PUNTO_PARTIDA_1 strPuntoPartida1,
	PUNTO_LLEGADA_1 strPuntoLlegada1,
	RAZON_SOCIAL_2 strRazonSocialTransportista2,
	DIRECCION_2 strDireccionTransportista2,
	RUC_2 strRucTransportista2,
	PUNTO_PARTIDA_2 strPuntoPartida2,
	PUNTO_LLEGADA_2 strPuntoLlegada2,
	RAZON_SOCIAL_3 strRazonSocialTransportista3,
	DIRECCION_3 strDireccionTransportista3,
	RUC_3 strRucTransportista3,
	PUNTO_PARTIDA_3 strPuntoPartida3,
	PUNTO_LLEGADA_3 strPuntoLlegada3,
	RAZON_SOCIAL_4 strRazonSocialTransportista4,
	DIRECCION_4 strDireccionTransportista4,
	RUC_4 strRucTransportista4,
	PUNTO_PARTIDA_4 strPuntoPartida4,
	PUNTO_LLEGADA_4 strPuntoLlegada4,
	RAZON_SOCIAL_5 strRazonSocialTransportista5,
	DIRECCION_5 strDireccionTransportista5,
	RUC_5 strRucTransportista5,
	PUNTO_PARTIDA_5 strPuntoPartida5,
	PUNTO_LLEGADA_5 strPuntoLlegada5,
	CROSSDOCK_1 strCrossDock1,
	CROSSDOCK_2 strCrossDock2,
	CROSSDOCK_3 strCrossDock3, 
	CROSSDOCK_4 strCrossDock4,
	CROSSDOCK_5 strCrossDock5,
	ZONA_REPARTO strCodigoZona,
	ZONA_REPARTO_DESCRIPCION strZonaRepartoDescripcion
	into ##temp_Despacho
FROM EADD.DESPACHO D WITH(NOLOCK)
WHERE D.NUMERO_ORDEN IN (SELECT NUMERO_ORDEN FROM #TMP_JMETER_TEST01)
