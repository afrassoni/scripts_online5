'reinit'
'open ../datain/obs/200601/prec_20060102.ctl'
'open ../datain/G3D-EN-accpr-MC-A-2006-01-02-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ../datain/G3D-EN-accpr-MC-A-2006-01-02-120000-g1.bin'
'd lterp(aprmc.2(t=1),prec.1)'
'disable fwrite'
'close 2'

'open ../datain/G3D-EN-accpr-LO-A-2006-01-02-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ../datain/G3D-EN-accpr-LO-A-2006-01-02-120000-g1.bin'
'd lterp(aprw.2(t=1),prec.1)'
'disable fwrite'
'close 2'

'open ../datain/G3D-EN-accpr-KF-A-2006-01-02-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ../datain/G3D-EN-accpr-KF-A-2006-01-02-120000-g1.bin'
'd lterp(aprst.2(t=1),prec.1)'
'disable fwrite'
'close 2'

'open ../datain/G3D-EN-accpr-GR-A-2006-01-02-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ../datain/G3D-EN-accpr-GR-A-2006-01-02-120000-g1.bin'
'd lterp(aprgr.2(t=1),prec.1)'
'disable fwrite'
'close 2'

'open ../datain/G3D-EN-accpr-AS-A-2006-01-02-120000-g1.ctl'
'set gxout fwrite'
'set fwrite ../datain/G3D-EN-accpr-AS-A-2006-01-02-120000-g1.bin'
'd lterp(apras.2(t=1),prec.1)'
'disable fwrite'
'close 2'

'quit'
