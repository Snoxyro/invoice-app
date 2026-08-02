<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:app="urn:invoiceapp:extensions:v1" xmlns:ccts="urn:un:unece:uncefact:documentation:2" xmlns:clm54217="urn:un:unece:uncefact:codelist:specification:54217:2001" xmlns:clm5639="urn:un:unece:uncefact:codelist:specification:5639:1988" xmlns:clm66411="urn:un:unece:uncefact:codelist:specification:66411:2001" xmlns:clmIANAMIMEMediaType="urn:un:unece:uncefact:codelist:specification:IANAMIMEMediaType:2003" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="cac cbc ext app ccts clm54217 clm5639 clm66411 clmIANAMIMEMediaType fn link n1 qdt udt xbrldi xbrli xdt xlink xs xsd xsi">
  <xsl:character-map name="a">
    <xsl:output-character character="" string="" />
    <xsl:output-character character="" string="" />
  </xsl:character-map>
  <xsl:decimal-format name="european" decimal-separator="," grouping-separator="." NaN="" />
  <xsl:output version="4.0" method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" use-character-maps="a" />
  <xsl:param name="SV_OutputFormat" select="'HTML'" />
  <xsl:variable name="XML" select="/" />
  <xsl:template match="/">
    <html>
      <head>
        <title />

        <script type="text/javascript">
                   <![CDATA[var QRCode;!function(){function a(a){this.mode=c.MODE_8BIT_BYTE,this.data=a,this.parsedData=[];for(var b=[],d=0,e=this.data.length;e>d;d++){var f=this.data.charCodeAt(d);f>65536?(b[0]=240|(1835008&f)>>>18,b[1]=128|(258048&f)>>>12,b[2]=128|(4032&f)>>>6,b[3]=128|63&f):f>2048?(b[0]=224|(61440&f)>>>12,b[1]=128|(4032&f)>>>6,b[2]=128|63&f):f>128?(b[0]=192|(1984&f)>>>6,b[1]=128|63&f):b[0]=f,this.parsedData=this.parsedData.concat(b)}this.parsedData.length!=this.data.length&&(this.parsedData.unshift(191),this.parsedData.unshift(187),this.parsedData.unshift(239))}function b(a,b){this.typeNumber=a,this.errorCorrectLevel=b,this.modules=null,this.moduleCount=0,this.dataCache=null,this.dataList=[]}function i(a,b){if(void 0==a.length)throw new Error(a.length+"/"+b);for(var c=0;c<a.length&&0==a[c];)c++;this.num=new Array(a.length-c+b);for(var d=0;d<a.length-c;d++)this.num[d]=a[d+c]}function j(a,b){this.totalCount=a,this.dataCount=b}function k(){this.buffer=[],this.length=0}function m(){return"undefined"!=typeof CanvasRenderingContext2D}function n(){var a=!1,b=navigator.userAgent;return/android/i.test(b)&&(a=!0,aMat=b.toString().match(/android ([0-9]\.[0-9])/i),aMat&&aMat[1]&&(a=parseFloat(aMat[1]))),a}function r(a,b){for(var c=1,e=s(a),f=0,g=l.length;g>=f;f++){var h=0;switch(b){case d.L:h=l[f][0];break;case d.M:h=l[f][1];break;case d.Q:h=l[f][2];break;case d.H:h=l[f][3]}if(h>=e)break;c++}if(c>l.length)throw new Error("Too long data");return c}function s(a){var b=encodeURI(a).toString().replace(/\%[0-9a-fA-F]{2}/g,"a");return b.length+(b.length!=a?3:0)}a.prototype={getLength:function(){return this.parsedData.length},write:function(a){for(var b=0,c=this.parsedData.length;c>b;b++)a.put(this.parsedData[b],8)}},b.prototype={addData:function(b){var c=new a(b);this.dataList.push(c),this.dataCache=null},isDark:function(a,b){if(0>a||this.moduleCount<=a||0>b||this.moduleCount<=b)throw new Error(a+","+b);return this.modules[a][b]},getModuleCount:function(){return this.moduleCount},make:function(){this.makeImpl(!1,this.getBestMaskPattern())},makeImpl:function(a,c){this.moduleCount=4*this.typeNumber+17,this.modules=new Array(this.moduleCount);for(var d=0;d<this.moduleCount;d++){this.modules[d]=new Array(this.moduleCount);for(var e=0;e<this.moduleCount;e++)this.modules[d][e]=null}this.setupPositionProbePattern(0,0),this.setupPositionProbePattern(this.moduleCount-7,0),this.setupPositionProbePattern(0,this.moduleCount-7),this.setupPositionAdjustPattern(),this.setupTimingPattern(),this.setupTypeInfo(a,c),this.typeNumber>=7&&this.setupTypeNumber(a),null==this.dataCache&&(this.dataCache=b.createData(this.typeNumber,this.errorCorrectLevel,this.dataList)),this.mapData(this.dataCache,c)},setupPositionProbePattern:function(a,b){for(var c=-1;7>=c;c++)if(!(-1>=a+c||this.moduleCount<=a+c))for(var d=-1;7>=d;d++)-1>=b+d||this.moduleCount<=b+d||(this.modules[a+c][b+d]=c>=0&&6>=c&&(0==d||6==d)||d>=0&&6>=d&&(0==c||6==c)||c>=2&&4>=c&&d>=2&&4>=d?!0:!1)},getBestMaskPattern:function(){for(var a=0,b=0,c=0;8>c;c++){this.makeImpl(!0,c);var d=f.getLostPoint(this);(0==c||a>d)&&(a=d,b=c)}return b},createMovieClip:function(a,b,c){var d=a.createEmptyMovieClip(b,c),e=1;this.make();for(var f=0;f<this.modules.length;f++)for(var g=f*e,h=0;h<this.modules[f].length;h++){var i=h*e,j=this.modules[f][h];j&&(d.beginFill(0,100),d.moveTo(i,g),d.lineTo(i+e,g),d.lineTo(i+e,g+e),d.lineTo(i,g+e),d.endFill())}return d},setupTimingPattern:function(){for(var a=8;a<this.moduleCount-8;a++)null==this.modules[a][6]&&(this.modules[a][6]=0==a%2);for(var b=8;b<this.moduleCount-8;b++)null==this.modules[6][b]&&(this.modules[6][b]=0==b%2)},setupPositionAdjustPattern:function(){for(var a=f.getPatternPosition(this.typeNumber),b=0;b<a.length;b++)for(var c=0;c<a.length;c++){var d=a[b],e=a[c];if(null==this.modules[d][e])for(var g=-2;2>=g;g++)for(var h=-2;2>=h;h++)this.modules[d+g][e+h]=-2==g||2==g||-2==h||2==h||0==g&&0==h?!0:!1}},setupTypeNumber:function(a){for(var b=f.getBCHTypeNumber(this.typeNumber),c=0;18>c;c++){var d=!a&&1==(1&b>>c);this.modules[Math.floor(c/3)][c%3+this.moduleCount-8-3]=d}for(var c=0;18>c;c++){var d=!a&&1==(1&b>>c);this.modules[c%3+this.moduleCount-8-3][Math.floor(c/3)]=d}},setupTypeInfo:function(a,b){for(var c=this.errorCorrectLevel<<3|b,d=f.getBCHTypeInfo(c),e=0;15>e;e++){var g=!a&&1==(1&d>>e);6>e?this.modules[e][8]=g:8>e?this.modules[e+1][8]=g:this.modules[this.moduleCount-15+e][8]=g}for(var e=0;15>e;e++){var g=!a&&1==(1&d>>e);8>e?this.modules[8][this.moduleCount-e-1]=g:9>e?this.modules[8][15-e-1+1]=g:this.modules[8][15-e-1]=g}this.modules[this.moduleCount-8][8]=!a},mapData:function(a,b){for(var c=-1,d=this.moduleCount-1,e=7,g=0,h=this.moduleCount-1;h>0;h-=2)for(6==h&&h--;;){for(var i=0;2>i;i++)if(null==this.modules[d][h-i]){var j=!1;g<a.length&&(j=1==(1&a[g]>>>e));var k=f.getMask(b,d,h-i);k&&(j=!j),this.modules[d][h-i]=j,e--,-1==e&&(g++,e=7)}if(d+=c,0>d||this.moduleCount<=d){d-=c,c=-c;break}}}},b.PAD0=236,b.PAD1=17,b.createData=function(a,c,d){for(var e=j.getRSBlocks(a,c),g=new k,h=0;h<d.length;h++){var i=d[h];g.put(i.mode,4),g.put(i.getLength(),f.getLengthInBits(i.mode,a)),i.write(g)}for(var l=0,h=0;h<e.length;h++)l+=e[h].dataCount;if(g.getLengthInBits()>8*l)throw new Error("code length overflow. ("+g.getLengthInBits()+">"+8*l+")");for(g.getLengthInBits()+4<=8*l&&g.put(0,4);0!=g.getLengthInBits()%8;)g.putBit(!1);for(;;){if(g.getLengthInBits()>=8*l)break;if(g.put(b.PAD0,8),g.getLengthInBits()>=8*l)break;g.put(b.PAD1,8)}return b.createBytes(g,e)},b.createBytes=function(a,b){for(var c=0,d=0,e=0,g=new Array(b.length),h=new Array(b.length),j=0;j<b.length;j++){var k=b[j].dataCount,l=b[j].totalCount-k;d=Math.max(d,k),e=Math.max(e,l),g[j]=new Array(k);for(var m=0;m<g[j].length;m++)g[j][m]=255&a.buffer[m+c];c+=k;var n=f.getErrorCorrectPolynomial(l),o=new i(g[j],n.getLength()-1),p=o.mod(n);h[j]=new Array(n.getLength()-1);for(var m=0;m<h[j].length;m++){var q=m+p.getLength()-h[j].length;h[j][m]=q>=0?p.get(q):0}}for(var r=0,m=0;m<b.length;m++)r+=b[m].totalCount;for(var s=new Array(r),t=0,m=0;d>m;m++)for(var j=0;j<b.length;j++)m<g[j].length&&(s[t++]=g[j][m]);for(var m=0;e>m;m++)for(var j=0;j<b.length;j++)m<h[j].length&&(s[t++]=h[j][m]);return s};for(var c={MODE_NUMBER:1,MODE_ALPHA_NUM:2,MODE_8BIT_BYTE:4,MODE_KANJI:8},d={L:1,M:0,Q:3,H:2},e={PATTERN000:0,PATTERN001:1,PATTERN010:2,PATTERN011:3,PATTERN100:4,PATTERN101:5,PATTERN110:6,PATTERN111:7},f={PATTERN_POSITION_TABLE:[[],[6,18],[6,22],[6,26],[6,30],[6,34],[6,22,38],[6,24,42],[6,26,46],[6,28,50],[6,30,54],[6,32,58],[6,34,62],[6,26,46,66],[6,26,48,70],[6,26,50,74],[6,30,54,78],[6,30,56,82],[6,30,58,86],[6,34,62,90],[6,28,50,72,94],[6,26,50,74,98],[6,30,54,78,102],[6,28,54,80,106],[6,32,58,84,110],[6,30,58,86,114],[6,34,62,90,118],[6,26,50,74,98,122],[6,30,54,78,102,126],[6,26,52,78,104,130],[6,30,56,82,108,134],[6,34,60,86,112,138],[6,30,58,86,114,142],[6,34,62,90,118,146],[6,30,54,78,102,126,150],[6,24,50,76,102,128,154],[6,28,54,80,106,132,158],[6,32,58,84,110,136,162],[6,26,54,82,110,138,166],[6,30,58,86,114,142,170]],G15:1335,G18:7973,G15_MASK:21522,getBCHTypeInfo:function(a){for(var b=a<<10;f.getBCHDigit(b)-f.getBCHDigit(f.G15)>=0;)b^=f.G15<<f.getBCHDigit(b)-f.getBCHDigit(f.G15);return(a<<10|b)^f.G15_MASK},getBCHTypeNumber:function(a){for(var b=a<<12;f.getBCHDigit(b)-f.getBCHDigit(f.G18)>=0;)b^=f.G18<<f.getBCHDigit(b)-f.getBCHDigit(f.G18);return a<<12|b},getBCHDigit:function(a){for(var b=0;0!=a;)b++,a>>>=1;return b},getPatternPosition:function(a){return f.PATTERN_POSITION_TABLE[a-1]},getMask:function(a,b,c){switch(a){case e.PATTERN000:return 0==(b+c)%2;case e.PATTERN001:return 0==b%2;case e.PATTERN010:return 0==c%3;case e.PATTERN011:return 0==(b+c)%3;case e.PATTERN100:return 0==(Math.floor(b/2)+Math.floor(c/3))%2;case e.PATTERN101:return 0==b*c%2+b*c%3;case e.PATTERN110:return 0==(b*c%2+b*c%3)%2;case e.PATTERN111:return 0==(b*c%3+(b+c)%2)%2;default:throw new Error("bad maskPattern:"+a)}},getErrorCorrectPolynomial:function(a){for(var b=new i([1],0),c=0;a>c;c++)b=b.multiply(new i([1,g.gexp(c)],0));return b},getLengthInBits:function(a,b){if(b>=1&&10>b)switch(a){case c.MODE_NUMBER:return 10;case c.MODE_ALPHA_NUM:return 9;case c.MODE_8BIT_BYTE:return 8;case c.MODE_KANJI:return 8;default:throw new Error("mode:"+a)}else if(27>b)switch(a){case c.MODE_NUMBER:return 12;case c.MODE_ALPHA_NUM:return 11;case c.MODE_8BIT_BYTE:return 16;case c.MODE_KANJI:return 10;default:throw new Error("mode:"+a)}else{if(!(41>b))throw new Error("type:"+b);switch(a){case c.MODE_NUMBER:return 14;case c.MODE_ALPHA_NUM:return 13;case c.MODE_8BIT_BYTE:return 16;case c.MODE_KANJI:return 12;default:throw new Error("mode:"+a)}}},getLostPoint:function(a){for(var b=a.getModuleCount(),c=0,d=0;b>d;d++)for(var e=0;b>e;e++){for(var f=0,g=a.isDark(d,e),h=-1;1>=h;h++)if(!(0>d+h||d+h>=b))for(var i=-1;1>=i;i++)0>e+i||e+i>=b||(0!=h||0!=i)&&g==a.isDark(d+h,e+i)&&f++;f>5&&(c+=3+f-5)}for(var d=0;b-1>d;d++)for(var e=0;b-1>e;e++){var j=0;a.isDark(d,e)&&j++,a.isDark(d+1,e)&&j++,a.isDark(d,e+1)&&j++,a.isDark(d+1,e+1)&&j++,(0==j||4==j)&&(c+=3)}for(var d=0;b>d;d++)for(var e=0;b-6>e;e++)a.isDark(d,e)&&!a.isDark(d,e+1)&&a.isDark(d,e+2)&&a.isDark(d,e+3)&&a.isDark(d,e+4)&&!a.isDark(d,e+5)&&a.isDark(d,e+6)&&(c+=40);for(var e=0;b>e;e++)for(var d=0;b-6>d;d++)a.isDark(d,e)&&!a.isDark(d+1,e)&&a.isDark(d+2,e)&&a.isDark(d+3,e)&&a.isDark(d+4,e)&&!a.isDark(d+5,e)&&a.isDark(d+6,e)&&(c+=40);for(var k=0,e=0;b>e;e++)for(var d=0;b>d;d++)a.isDark(d,e)&&k++;var l=Math.abs(100*k/b/b-50)/5;return c+=10*l}},g={glog:function(a){if(1>a)throw new Error("glog("+a+")");return g.LOG_TABLE[a]},gexp:function(a){for(;0>a;)a+=255;for(;a>=256;)a-=255;return g.EXP_TABLE[a]},EXP_TABLE:new Array(256),LOG_TABLE:new Array(256)},h=0;8>h;h++)g.EXP_TABLE[h]=1<<h;for(var h=8;256>h;h++)g.EXP_TABLE[h]=g.EXP_TABLE[h-4]^g.EXP_TABLE[h-5]^g.EXP_TABLE[h-6]^g.EXP_TABLE[h-8];for(var h=0;255>h;h++)g.LOG_TABLE[g.EXP_TABLE[h]]=h;i.prototype={get:function(a){return this.num[a]},getLength:function(){return this.num.length},multiply:function(a){for(var b=new Array(this.getLength()+a.getLength()-1),c=0;c<this.getLength();c++)for(var d=0;d<a.getLength();d++)b[c+d]^=g.gexp(g.glog(this.get(c))+g.glog(a.get(d)));return new i(b,0)},mod:function(a){if(this.getLength()-a.getLength()<0)return this;for(var b=g.glog(this.get(0))-g.glog(a.get(0)),c=new Array(this.getLength()),d=0;d<this.getLength();d++)c[d]=this.get(d);for(var d=0;d<a.getLength();d++)c[d]^=g.gexp(g.glog(a.get(d))+b);return new i(c,0).mod(a)}},j.RS_BLOCK_TABLE=[[1,26,19],[1,26,16],[1,26,13],[1,26,9],[1,44,34],[1,44,28],[1,44,22],[1,44,16],[1,70,55],[1,70,44],[2,35,17],[2,35,13],[1,100,80],[2,50,32],[2,50,24],[4,25,9],[1,134,108],[2,67,43],[2,33,15,2,34,16],[2,33,11,2,34,12],[2,86,68],[4,43,27],[4,43,19],[4,43,15],[2,98,78],[4,49,31],[2,32,14,4,33,15],[4,39,13,1,40,14],[2,121,97],[2,60,38,2,61,39],[4,40,18,2,41,19],[4,40,14,2,41,15],[2,146,116],[3,58,36,2,59,37],[4,36,16,4,37,17],[4,36,12,4,37,13],[2,86,68,2,87,69],[4,69,43,1,70,44],[6,43,19,2,44,20],[6,43,15,2,44,16],[4,101,81],[1,80,50,4,81,51],[4,50,22,4,51,23],[3,36,12,8,37,13],[2,116,92,2,117,93],[6,58,36,2,59,37],[4,46,20,6,47,21],[7,42,14,4,43,15],[4,133,107],[8,59,37,1,60,38],[8,44,20,4,45,21],[12,33,11,4,34,12],[3,145,115,1,146,116],[4,64,40,5,65,41],[11,36,16,5,37,17],[11,36,12,5,37,13],[5,109,87,1,110,88],[5,65,41,5,66,42],[5,54,24,7,55,25],[11,36,12],[5,122,98,1,123,99],[7,73,45,3,74,46],[15,43,19,2,44,20],[3,45,15,13,46,16],[1,135,107,5,136,108],[10,74,46,1,75,47],[1,50,22,15,51,23],[2,42,14,17,43,15],[5,150,120,1,151,121],[9,69,43,4,70,44],[17,50,22,1,51,23],[2,42,14,19,43,15],[3,141,113,4,142,114],[3,70,44,11,71,45],[17,47,21,4,48,22],[9,39,13,16,40,14],[3,135,107,5,136,108],[3,67,41,13,68,42],[15,54,24,5,55,25],[15,43,15,10,44,16],[4,144,116,4,145,117],[17,68,42],[17,50,22,6,51,23],[19,46,16,6,47,17],[2,139,111,7,140,112],[17,74,46],[7,54,24,16,55,25],[34,37,13],[4,151,121,5,152,122],[4,75,47,14,76,48],[11,54,24,14,55,25],[16,45,15,14,46,16],[6,147,117,4,148,118],[6,73,45,14,74,46],[11,54,24,16,55,25],[30,46,16,2,47,17],[8,132,106,4,133,107],[8,75,47,13,76,48],[7,54,24,22,55,25],[22,45,15,13,46,16],[10,142,114,2,143,115],[19,74,46,4,75,47],[28,50,22,6,51,23],[33,46,16,4,47,17],[8,152,122,4,153,123],[22,73,45,3,74,46],[8,53,23,26,54,24],[12,45,15,28,46,16],[3,147,117,10,148,118],[3,73,45,23,74,46],[4,54,24,31,55,25],[11,45,15,31,46,16],[7,146,116,7,147,117],[21,73,45,7,74,46],[1,53,23,37,54,24],[19,45,15,26,46,16],[5,145,115,10,146,116],[19,75,47,10,76,48],[15,54,24,25,55,25],[23,45,15,25,46,16],[13,145,115,3,146,116],[2,74,46,29,75,47],[42,54,24,1,55,25],[23,45,15,28,46,16],[17,145,115],[10,74,46,23,75,47],[10,54,24,35,55,25],[19,45,15,35,46,16],[17,145,115,1,146,116],[14,74,46,21,75,47],[29,54,24,19,55,25],[11,45,15,46,46,16],[13,145,115,6,146,116],[14,74,46,23,75,47],[44,54,24,7,55,25],[59,46,16,1,47,17],[12,151,121,7,152,122],[12,75,47,26,76,48],[39,54,24,14,55,25],[22,45,15,41,46,16],[6,151,121,14,152,122],[6,75,47,34,76,48],[46,54,24,10,55,25],[2,45,15,64,46,16],[17,152,122,4,153,123],[29,74,46,14,75,47],[49,54,24,10,55,25],[24,45,15,46,46,16],[4,152,122,18,153,123],[13,74,46,32,75,47],[48,54,24,14,55,25],[42,45,15,32,46,16],[20,147,117,4,148,118],[40,75,47,7,76,48],[43,54,24,22,55,25],[10,45,15,67,46,16],[19,148,118,6,149,119],[18,75,47,31,76,48],[34,54,24,34,55,25],[20,45,15,61,46,16]],j.getRSBlocks=function(a,b){var c=j.getRsBlockTable(a,b);if(void 0==c)throw new Error("bad rs block @ typeNumber:"+a+"/errorCorrectLevel:"+b);for(var d=c.length/3,e=[],f=0;d>f;f++)for(var g=c[3*f+0],h=c[3*f+1],i=c[3*f+2],k=0;g>k;k++)e.push(new j(h,i));return e},j.getRsBlockTable=function(a,b){switch(b){case d.L:return j.RS_BLOCK_TABLE[4*(a-1)+0];case d.M:return j.RS_BLOCK_TABLE[4*(a-1)+1];case d.Q:return j.RS_BLOCK_TABLE[4*(a-1)+2];case d.H:return j.RS_BLOCK_TABLE[4*(a-1)+3];default:return void 0}},k.prototype={get:function(a){var b=Math.floor(a/8);return 1==(1&this.buffer[b]>>>7-a%8)},put:function(a,b){for(var c=0;b>c;c++)this.putBit(1==(1&a>>>b-c-1))},getLengthInBits:function(){return this.length},putBit:function(a){var b=Math.floor(this.length/8);this.buffer.length<=b&&this.buffer.push(0),a&&(this.buffer[b]|=128>>>this.length%8),this.length++}};var l=[[17,14,11,7],[32,26,20,14],[53,42,32,24],[78,62,46,34],[106,84,60,44],[134,106,74,58],[154,122,86,64],[192,152,108,84],[230,180,130,98],[271,213,151,119],[321,251,177,137],[367,287,203,155],[425,331,241,177],[458,362,258,194],[520,412,292,220],[586,450,322,250],[644,504,364,280],[718,560,394,310],[792,624,442,338],[858,666,482,382],[929,711,509,403],[1003,779,565,439],[1091,857,611,461],[1171,911,661,511],[1273,997,715,535],[1367,1059,751,593],[1465,1125,805,625],[1528,1190,868,658],[1628,1264,908,698],[1732,1370,982,742],[1840,1452,1030,790],[1952,1538,1112,842],[2068,1628,1168,898],[2188,1722,1228,958],[2303,1809,1283,983],[2431,1911,1351,1051],[2563,1989,1423,1093],[2699,2099,1499,1139],[2809,2213,1579,1219],[2953,2331,1663,1273]],o=function(){var a=function(a,b){this._el=a,this._htOption=b};return a.prototype.draw=function(a){function g(a,b){var c=document.createElementNS("http://www.w3.org/2000/svg",a);for(var d in b)b.hasOwnProperty(d)&&c.setAttribute(d,b[d]);return c}var b=this._htOption,c=this._el,d=a.getModuleCount();Math.floor(b.width/d),Math.floor(b.height/d),this.clear();var h=g("svg",{viewBox:"0 0 "+String(d)+" "+String(d),width:"100%",height:"100%",fill:b.colorLight});h.setAttributeNS("http://www.w3.org/2000/xmlns/","xmlns:xlink","http://www.w3.org/1999/xlink"),c.appendChild(h),h.appendChild(g("rect",{fill:b.colorDark,width:"1",height:"1",id:"template"}));for(var i=0;d>i;i++)for(var j=0;d>j;j++)if(a.isDark(i,j)){var k=g("use",{x:String(i),y:String(j)});k.setAttributeNS("http://www.w3.org/1999/xlink","href","#template"),h.appendChild(k)}},a.prototype.clear=function(){for(;this._el.hasChildNodes();)this._el.removeChild(this._el.lastChild)},a}(),p="svg"===document.documentElement.tagName.toLowerCase(),q=p?o:m()?function(){function a(){this._elImage.src=this._elCanvas.toDataURL("image/png"),this._elImage.style.display="block",this._elCanvas.style.display="none"}function d(a,b){var c=this;if(c._fFail=b,c._fSuccess=a,null===c._bSupportDataURI){var d=document.createElement("img"),e=function(){c._bSupportDataURI=!1,c._fFail&&_fFail.call(c)},f=function(){c._bSupportDataURI=!0,c._fSuccess&&c._fSuccess.call(c)};return d.onabort=e,d.onerror=e,d.onload=f,d.src="data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",void 0}c._bSupportDataURI===!0&&c._fSuccess?c._fSuccess.call(c):c._bSupportDataURI===!1&&c._fFail&&c._fFail.call(c)}if(this._android&&this._android<=2.1){var b=1/window.devicePixelRatio,c=CanvasRenderingContext2D.prototype.drawImage;CanvasRenderingContext2D.prototype.drawImage=function(a,d,e,f,g,h,i,j){if("nodeName"in a&&/img/i.test(a.nodeName))for(var l=arguments.length-1;l>=1;l--)arguments[l]=arguments[l]*b;else"undefined"==typeof j&&(arguments[1]*=b,arguments[2]*=b,arguments[3]*=b,arguments[4]*=b);c.apply(this,arguments)}}var e=function(a,b){this._bIsPainted=!1,this._android=n(),this._htOption=b,this._elCanvas=document.createElement("canvas"),this._elCanvas.width=b.width,this._elCanvas.height=b.height,a.appendChild(this._elCanvas),this._el=a,this._oContext=this._elCanvas.getContext("2d"),this._bIsPainted=!1,this._elImage=document.createElement("img"),this._elImage.style.display="none",this._el.appendChild(this._elImage),this._bSupportDataURI=null};return e.prototype.draw=function(a){var b=this._elImage,c=this._oContext,d=this._htOption,e=a.getModuleCount(),f=d.width/e,g=d.height/e,h=Math.round(f),i=Math.round(g);b.style.display="none",this.clear();for(var j=0;e>j;j++)for(var k=0;e>k;k++){var l=a.isDark(j,k),m=k*f,n=j*g;c.strokeStyle=l?d.colorDark:d.colorLight,c.lineWidth=1,c.fillStyle=l?d.colorDark:d.colorLight,c.fillRect(m,n,f,g),c.strokeRect(Math.floor(m)+.5,Math.floor(n)+.5,h,i),c.strokeRect(Math.ceil(m)-.5,Math.ceil(n)-.5,h,i)}this._bIsPainted=!0},e.prototype.makeImage=function(){this._bIsPainted&&d.call(this,a)},e.prototype.isPainted=function(){return this._bIsPainted},e.prototype.clear=function(){this._oContext.clearRect(0,0,this._elCanvas.width,this._elCanvas.height),this._bIsPainted=!1},e.prototype.round=function(a){return a?Math.floor(1e3*a)/1e3:a},e}():function(){var a=function(a,b){this._el=a,this._htOption=b};return a.prototype.draw=function(a){for(var b=this._htOption,c=this._el,d=a.getModuleCount(),e=Math.floor(b.width/d),f=Math.floor(b.height/d),g=['<table style="border:0;border-collapse:collapse;">'],h=0;d>h;h++){g.push("<tr>");for(var i=0;d>i;i++)g.push('<td style="border:0;border-collapse:collapse;padding:0;margin:0;width:'+e+"px;height:"+f+"px;background-color:"+(a.isDark(h,i)?b.colorDark:b.colorLight)+';"></td>');g.push("</tr>")}g.push("</table>"),c.innerHTML=g.join("");var j=c.childNodes[0],k=(b.width-j.offsetWidth)/2,l=(b.height-j.offsetHeight)/2;k>0&&l>0&&(j.style.margin=l+"px "+k+"px")},a.prototype.clear=function(){this._el.innerHTML=""},a}();QRCode=function(a,b){if(this._htOption={width:256,height:256,typeNumber:4,colorDark:"#000000",colorLight:"#ffffff",correctLevel:d.H},"string"==typeof b&&(b={text:b}),b)for(var c in b)this._htOption[c]=b[c];"string"==typeof a&&(a=document.getElementById(a)),this._android=n(),this._el=a,this._oQRCode=null,this._oDrawing=new q(this._el,this._htOption),this._htOption.text&&this.makeCode(this._htOption.text)},QRCode.prototype.makeCode=function(a){this._oQRCode=new b(r(a,this._htOption.correctLevel),this._htOption.correctLevel),this._oQRCode.addData(a),this._oQRCode.make(),this._el.title=a,this._oDrawing.draw(this._oQRCode),this.makeImage()},QRCode.prototype.makeImage=function(){"function"==typeof this._oDrawing.makeImage&&(!this._android||this._android>=3)&&this._oDrawing.makeImage()},QRCode.prototype.clear=function(){this._oDrawing.clear()},QRCode.CorrectLevel=d}();]]>      
        </script>

        <style type="text/css">
                  body {
                  background-color: #FFFFFF;
                  font-family: 'Tahoma', "Times New Roman", Times, serif;
                  font-size: 11px;
                  color: black;
                  }
                  h1, h2 {
                  padding-bottom: 3px;
                  padding-top: 3px;
                  margin-bottom: 5px;
                  text-transform: uppercase;
                  font-family: Arial, Helvetica, sans-serif;
                  }
                  h1 {
                  font-size: 1.4em;
                  text-transform:none;
                  }
                  h2 {
                  font-size: 1em;
                  color: brown;
                  }
                  h3 {
                  font-size: 1em;
                  color: #333333;
                  text-align: justify;
                  margin: 0;
                  padding: 0;
                  }
                  h4 {
                  font-size: 1.1em;
                  font-style: bold;
                  font-family: Arial, Helvetica, sans-serif;
                  color: #000000;
                  margin: 0;
                  padding: 0;
                  }
                  #customername{            
                  font-size:13px;
                  color: #000000;
                  }
                  p, ul, ol {
                  margin-top: 1.5em;
                  }
                  ul, ol {
                  margin-left: 3em;
                  }
                  blockquote {
                  margin-left: 3em;
                  margin-right: 3em;
                  font-style: italic;
                  }
                  a {
                  text-decoration: none;
                  color: #70A300;
                  }
                  a:hover {
                  border: none;
                  color: #70A300;
                  }
                  #despatchTable {
                  border-collapse:collapse;
                  font-size:11px;
                  float:right;
                  border-color:gray;
                  }
                  #ettnTable {
                  border-collapse:collapse;
                  font-size:11px;
                  border-color:gray;
                  }
                  #customerPartyTable {
                  border-width: 0px;
                  border-spacing:;
                  border-style: inset;
                  border-color: gray;
                  border-collapse: collapse;
                  background-color:
                  }
                  #customerIDTable {
                  border-width: 2px;
                  border-spacing:;
                  border-style: inset;
                  border-color: gray;
                  border-collapse: collapse;
                  background-color:
                  }
                  #customerIDTableTd {
                  border-width: 2px;
                  border-spacing:;
                  border-style: inset;
                  border-color: gray;
                  border-collapse: collapse;
                  background-color:
                  }
                  #lineTable {
                  border-width:2px;
                  border-spacing:;
                  border-style: solid;
                  border-color: #000000;
                  border-collapse: collapse;
                  background-color:;
                  }
                  #lineTableTd {
                  border-width: 1px;
                  padding: 1px;
                  border-style: solid;
                  border-color: #000000 ;            
                  }
                  #lineTableTr {
                  border-width: 1px;
                  padding: 0px;
                  background-color: white;
                  border-color: #000000 ;
                  -moz-border-radius:;
                  }
                  #lineTableDummyTd {
                  border-width: 1px;
                  border-color:white;
                  padding: 1px;
                  border-style: inset;
                  border-color: black;
                  background-color: white;
                  }
                  #lineTableBudgetTd {
                  }
                  #notesTable {
                  border-width: 1px;
                  border-spacing:;
                  border-style: solid;
                  border-color: #000000;
                  border-collapse: collapse;
                  background-color:
                  }
                  #notesTableTd {
                  border-width: 0px;
                  border-spacing:;
                  border-style: inset;
                  border-color: black;
                  border-collapse: collapse;
                  background-color:
                  }
                  table {
                  border-spacing:0px;
                  }
                  #budgetContainerTable {
                  border-collapse:collapse;
                  border-width: 0px;
                  border-spacing: 0px;
                  border-style: inset;
                  border-color: black;
                  background-color:;
                  margin-top: 7px;
                  margin-bottom: 30px;
                  }
                  #budgetContainerTable td{
                  border-bottom: 1px solid #ddd;
                  }
                  td {
                  border-color:gray;
                  }
                  @media print{
                  i{
                  font-style: italic !important;
                  }
                  }
                  #bankingTable{
                  border-collapse:collapse;
                  border-width: 1px;
                  border-style: inset;
                  font-size:11px;
                  float:leftt;
                  border-color:#000000;
                  }
                  #bankingTable th{
                  float:leftt;
                  border-color:gray;
                  background-color:#000000;
                  color: white;
                  }
                  <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:FontFamily = 'Inter'">
                  @font-face {
                  font-family: 'Inter';
                  font-style: normal;
                  font-weight: 400;
                  src: url(data:font/woff2;base64,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) format('woff2');
                  }
                  @font-face {
                  font-family: 'Inter';
                  font-style: normal;
                  font-weight: 700;
                  src: url(data:font/woff2;base64,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) format('woff2');
                  }
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:FontFamily = 'Roboto'">
                  @font-face {
                  font-family: 'Roboto';
                  font-style: normal;
                  font-weight: 400;
                  src: url(data:font/woff2;base64,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) format('woff2');
                  }
                  @font-face {
                  font-family: 'Roboto';
                  font-style: normal;
                  font-weight: 700;
                  src: url(data:font/woff2;base64,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) format('woff2');
                  }
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:FontFamily">
                  body, body * { font-family: "<xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:FontFamily" />", Arial, Helvetica, sans-serif !important; }
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:AccentColorHex">
                  #customername { color: <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:AccentColorHex" /> !important; }
                  </xsl:if>
               </style>
        <title>e-Fatura</title>
      </head>
      <body style="margin-left=0.6in; margin-right=0.6in; margin-top=0.79in; margin-bottom=0.79in">
        <xsl:for-each select="$XML">
          <table style="border-color:blue; " border="0" cellspacing="0px" width="800px" cellpadding="0px">
            <tbody>
              <tr valign="top">
                <td width="40%">
                  <br />
                  <xsl:choose>
                    <xsl:when test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoBase64">
                      <img alt="" id="company_logo" name="company_logo">
                        <xsl:attribute name="src">
                          <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoBase64" />
                        </xsl:attribute>
                        <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoWidthPx">
                          <xsl:attribute name="width">
                            <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoWidthPx" />
                          </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoHeightPx">
                          <xsl:attribute name="height">
                            <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:LogoHeightPx" />
                          </xsl:attribute>
                        </xsl:if>
                      </img>
                    </xsl:when>
                    <xsl:otherwise>
                      <img alt="" id="company_logo" name="company_logo"  src="data:image/jpeg;base64,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" />
                    </xsl:otherwise>
                  </xsl:choose>
                  <br />
                  <br />
                  <table align="center" border="0" width="100%">
                    <tbody>
                      <tr align="left">
                        <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                          <td align="left">
                            <xsl:if test="cac:PartyName">
                              <b id="customername">
                                <xsl:if test="cac:PartyName">
                                  <xsl:value-of select="cac:PartyName/cbc:Name" />
                                </xsl:if>
                              </b>
                            </xsl:if>
                          </td>
                        </xsl:for-each>
                      </tr>
                      <tr align="left">
                        <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                          <td align="left">
                            <xsl:for-each select="cac:PostalAddress">
                              <xsl:for-each select="cbc:StreetName">
                                <xsl:apply-templates />
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                              <xsl:for-each select="cbc:BuildingName">
                                <xsl:apply-templates />
                              </xsl:for-each>
                              <br />
                              <xsl:for-each select="cbc:PostalZone">
                                <xsl:apply-templates />
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                              <xsl:for-each select="cbc:CitySubdivisionName">
                                <xsl:apply-templates />
                              </xsl:for-each>
                              <xsl:text>/ </xsl:text>
                              <xsl:for-each select="cbc:CityName">
                                <xsl:apply-templates />
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                              <xsl:text>/TÜRKİYE</xsl:text>
                            </xsl:for-each>
                          </td>
                        </xsl:for-each>
                      </tr>
                      <xsl:if test="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone or //n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax">
                        <tr align="left">
                          <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                            <td align="left">
                              <xsl:for-each select="cac:Contact">
                                <xsl:if test="cbc:Telephone">
                                  <xsl:text>Tel: </xsl:text>
                                  <xsl:for-each select="cbc:Telephone">
                                    <xsl:apply-templates />
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test="cbc:Telefax">
                                  <xsl:text> Fax: </xsl:text>
                                  <xsl:for-each select="cbc:Telefax">
                                    <xsl:apply-templates />
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:text> </xsl:text>
                              </xsl:for-each>
                            </td>
                          </xsl:for-each>
                        </tr>
                      </xsl:if>
                      <xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cbc:WebsiteURI">
                        <tr align="left">
                          <td>
                            <xsl:text>Web Sitesi: </xsl:text>
                            <xsl:value-of select="." />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail">
                        <tr align="left">
                          <td>
                            <xsl:text>E-Posta: </xsl:text>
                            <xsl:value-of select="." />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <tr align="left">
                        <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party">
                          <td align="left">
                            <xsl:text>Vergi Dairesi: </xsl:text>
                            <xsl:for-each select="cac:PartyTaxScheme">
                              <xsl:for-each select="cac:TaxScheme">
                                <xsl:for-each select="cbc:Name">
                                  <xsl:apply-templates />
                                </xsl:for-each>
                              </xsl:for-each>
                              <xsl:text>  </xsl:text>
                            </xsl:for-each>
                          </td>
                        </xsl:for-each>
                      </tr>
                      <xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification">
                        <tr align="left">
                          <td>
                            <xsl:value-of select="cbc:ID/@schemeID" />
                            <xsl:text>: </xsl:text>
                            <xsl:value-of select="cbc:ID" />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty">
                        <tr>
                          <td style="width:469px; " align="left">
                            <b>Şube Bilgileri</b>
                            <br />
                            <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
                              <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyName">
                                <b>
                                  <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyName/cbc:Name" />
                                </b>
                              </xsl:if>
                            </xsl:if>
                            <xsl:if test="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
                              <b>
                                <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:Person">
                                  <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cbc:FirstName">
                                    <xsl:apply-templates />
                                    <xsl:text>
                                    </xsl:text>
                                  </xsl:for-each>
                                  <xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cbc:FamilyName">
                                    <xsl:apply-templates />
                                    <xsl:text>
                                    </xsl:text>
                                  </xsl:for-each>
                                </xsl:for-each>
                              </b>
                            </xsl:if>
                            <br />
                            <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:StreetName" />
                            <br />
                            <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CitySubdivisionName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CityName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:Name" /><br />

                                          Vergi Dairesi: 
                                          <xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name" /><br /><xsl:for-each select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:AgentParty/cac:PartyIdentification"><tr align="left"><td><xsl:value-of select="cbc:ID/@schemeID" /><xsl:text>: </xsl:text><xsl:value-of select="cbc:ID" /></td></tr></xsl:for-each></td>
                        </tr>
                      </xsl:if>
                    </tbody>
                  </table>
                </td>
                <td width="20%" align="center" valign="middle">
                  <img style="width:120px;" align="middle" alt="E-Fatura Logo" src="data:image/png;base64,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" />
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'EARSIVFATURA'">
                    <h1 align="center">
                      <span style="font-weight:bold; ">
                        <xsl:text>e-Arşiv Fatura</xsl:text>
                      </span>
                    </h1>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID != 'EARSIVFATURA'">
                    <h1 align="center">
                      <span style="font-weight:bold; ">
                        <xsl:text>e-Fatura</xsl:text>
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:10px;font-style:italic;color:#808080;">
                          <br />
                          <xsl:text>e-Invoice</xsl:text>
                        </span>
                      </xsl:if>
                    </h1>
                  </xsl:if>
                </td>
                <td align="center" valign="middle" width="20%">
          
                  <img width="180" height="180" align="right"  id="qrkod" name="qrkod" src="{KAREKODGELECEK}"/>
                  
                  <div align="right" id="qrcode"/>
                  <div id="qrvalue"
                    style="visibility: hidden; height: 20px;width: 20px; ; display:none"
                    > {"vkntckn":"<xsl:value-of select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID = 'TCKN' or @schemeID = 'VKN']"/>", "avkntckn":"<xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID = 'TCKN' or @schemeID = 'VKN']"/><xsl:text> </xsl:text>", "senaryo":"<xsl:value-of select="n1:Invoice/cbc:ProfileID"/>", "tip":"<xsl:value-of select="n1:Invoice/cbc:InvoiceTypeCode"/>", "tarih":"<xsl:value-of select="n1:Invoice/cbc:IssueDate"/>", "no":"<xsl:value-of select="n1:Invoice/cbc:ID"/>", "ettn":"<xsl:value-of select="n1:Invoice/cbc:UUID"/>", "parabirimi":"<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>", "malhizmettoplam":"<xsl:value-of select="n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount"/><xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '0015']">"<xsl:text>, "kdvmatrah</xsl:text>(<xsl:value-of select="cbc:Percent"/>)":"<xsl:value-of select="cbc:TaxableAmount"/>"</xsl:for-each><xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '0015']"><xsl:text>, "hesaplanankdv</xsl:text>(<xsl:value-of select="cbc:Percent"/>)":"<xsl:value-of select="cbc:TaxAmount"/>",</xsl:for-each>"vergidahil":"<xsl:value-of select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>", "odenecek":"<xsl:value-of select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount"/>"}
                  </div>
                  <script type="text/javascript">                    
                    const element = document.getElementById("qrkod");
                    if(element.src.length >= 1000){
                        //qr mevcut
                    }
                    else{
                        var qrcode = new QRCode(document.getElementById("qrcode"), {
                          width : 180,
                          height : 180,
                          correctLevel : QRCode.CorrectLevel.H
                        });
                        function makeCode (msg) {   
                          var elText = document.getElementById("text");
                          qrcode.makeCode(msg);
                        }
                       makeCode(document.getElementById("qrvalue").innerHTML); 
                       element.parentNode.removeChild(element);
                    }
                  </script>
                </td>
              </tr>
              <tr style="height:90px; " valign="top">
                <td width="40%" align="right" valign="bottom">
                  <table id="customerPartyTable" align="left" border="0" style="margin-top:50px;" height="40%">
                    <tbody>

                      <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                        <tr style="height:35px; ">
                          <hr style="display: block;&#xD;&#xA;                                          height: 1px;&#xD;&#xA;                                          border: 0;&#xD;&#xA;                                          border-top: 1px solid #000000;&#xD;&#xA;                                          padding: 0; " />
                          <td>
                            <table align="center" border="0">
                              <tbody>
                                <tr>
                                  <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                    <td style="width:469px; " align="left">
                                      <span style="font-weight:bold;color:#000000; ">
                                        <xsl:text>Alıcı Bilgileri</xsl:text>
                                      </span>
                                      <!--  <i style="font-size:10px;font-style:italic !important;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                                            <br/><xsl:text>Buyer Information</xsl:text>
                                                            </i> -->
                                    </td>
                                  </xsl:for-each>
                                </tr>
                                <tr>
                                  <xsl:choose>
                                    <xsl:when test="n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID='PARTYTYPE' and text()='TAXFREE']">
                                      <xsl:for-each select="n1:Invoice/cac:BuyerCustomerParty/cac:Party">
                                        <xsl:call-template name="Party_Title">
                                          <xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
                                        </xsl:call-template>
                                      </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                        <xsl:call-template name="Party_Title">
                                          <xsl:with-param name="PartyType">OTHER</xsl:with-param>
                                        </xsl:call-template>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </tr>
                                <xsl:choose>
                                  <xsl:when test="n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID='PARTYTYPE' and text()='TAXFREE']">
                                    <xsl:for-each select="n1:Invoice/cac:BuyerCustomerParty/cac:Party">
                                      <tr>
                                        <xsl:call-template name="Party_Adress">
                                          <xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
                                        </xsl:call-template>
                                      </tr>
                                      <xsl:call-template name="Party_Other">
                                        <xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
                                      </xsl:call-template>
                                    </xsl:for-each>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                      <tr>
                                        <xsl:call-template name="Party_Adress">
                                          <xsl:with-param name="PartyType">OTHER</xsl:with-param>
                                        </xsl:call-template>
                                      </tr>
                                      <xsl:call-template name="Party_Other">
                                        <xsl:with-param name="PartyType">OTHER</xsl:with-param>
                                      </xsl:call-template>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>

                                <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty">
                                  <tr>
                                    <td style="width:469px; " align="left">
                                      <b>Şube Bilgileri</b>
                                      <br />
                                      <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
                                        <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyName">
                                          <b>
                                            <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyName/cbc:Name" />
                                          </b>
                                        </xsl:if>
                                      </xsl:if>
                                      <xsl:if test="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
                                        <b>
                                          <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:Person">
                                            <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cbc:FirstName">
                                              <xsl:apply-templates />
                                              <xsl:text>
                                              </xsl:text>
                                            </xsl:for-each>
                                            <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cbc:FamilyName">
                                              <xsl:apply-templates />
                                              <xsl:text>
                                              </xsl:text>
                                            </xsl:for-each>
                                          </xsl:for-each>
                                        </b>
                                      </xsl:if>
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:StreetName" />
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CitySubdivisionName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CityName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:Name" /><br />

                                          Vergi Dairesi: 
                                          <xsl:value-of select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name" /><br /><xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification"><tr align="left"><td><xsl:value-of select="cbc:ID/@schemeID" /><xsl:text>: </xsl:text><xsl:value-of select="cbc:ID" /></td></tr></xsl:for-each></td>
                                  </tr>
                                </xsl:if>


                               <xsl:if test="n1:Invoice/cac:Delivery/cac:DeliveryAddress">
                                  <tr>
                                    <td style="width:469px; " align="left">
                                      <b>Teslimat Bilgileri</b>
                                      <br />        
                                      <xsl:value-of select="n1:Invoice/cac:Delivery/cbc:ID" />
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:StreetName" />
                                      <br />
                                      <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:CityName" />
                                                  /
                                                  <xsl:value-of select="n1:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:Name" /><br />

                                   
                                      </td>
                                  </tr>
                                </xsl:if>


                              </tbody>
                            </table>
                            <hr style="display: block;&#xD;&#xA;                                             height: 1px;&#xD;&#xA;                                             border: 0;&#xD;&#xA;                                             border-top: 1px solid #000000;&#xD;&#xA;                                             padding: 0; " />
                          </td>
                        </tr>
                      </xsl:if>

                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <tr style="height:71px; ">
                          <td>
                            <hr style="display: block;&#xD;&#xA;                                             height: 1px;&#xD;&#xA;                                             border: 0;&#xD;&#xA;                                             border-top: 1px solid #000000;&#xD;&#xA;                                             padding: 0; " />
                            <table align="center" border="0">
                              <tbody>
                                <tr>
                                  <xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
                                    <td style="width:469px; " align="left">
                                      <span style="font-weight:bold;color:#000000; ">
                                        <xsl:text>Alıcı Bilgileri</xsl:text>
                                      </span>
                                      <i style="font-size:10px;font-style:italic !important;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                        <br />
                                        <xsl:text>Buyer Information</xsl:text>
                                      </i>
                                    </td>
                                  </xsl:for-each>
                                </tr>
                                <tr>
                                  <tr>
                                    <td style="width:469px" align="left">
                                      <span style="font-weight:bold; ">
                                        <xsl:text>
                                        </xsl:text>
                                      </span>
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                                    </td>
                                  </tr>
                                </tr>
                                <tr>
                                  <td style="width:469px" align="left">
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''&#xD;&#xA;                                          and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName !='-'">
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
                                      <br />
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName !=''&#xD;&#xA;                                         and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName !='-'">
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName !=''&#xD;&#xA;                                  and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName !='-'">
                                      <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:Name" />
                                    <xsl:if test="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name !=''&#xD;&#xA;                                   and  //n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name !='-'">
                                      <br />Tax Office:<xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name" /></xsl:if>
                                    <br />Company ID: <xsl:value-of select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" /></td>
                                </tr>
                                <tr>
                                  <td style="width:469px" align="left">
                                    <span style="font-weight:bold; ">
                                                          Consignee: <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cbc:ID/node())[1]" /></span>
                                  </td>
                                </tr>
                                <tr>
                                  <td style="width:469px" align="left">
                                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:StreetName !=''&#xD;&#xA;                            and //n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:StreetName !='-' ">
                                      <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:StreetName/node())[1]" />
                                      <br />
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName !=''&#xD;&#xA;                            and //n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName  !='-'">
                                      <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName/node())[1]" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CityName !=''&#xD;&#xA;                           and //n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CityName !='-'">
                                      <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cbc:CityName/node())[1]" />
                                      <xsl:text>/</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:Name/node())[1]" />
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <hr style="display: block;&#xD;&#xA;                                             height: 1px;&#xD;&#xA;                                             border: 0;&#xD;&#xA;                                             border-top: 1px solid #000000;&#xD;&#xA;                                             padding: 0; " />
                          </td>
                        </tr>
                      </xsl:if>


                    </tbody>
                  </table>
                  <br />
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'EARSIVFATURA'">
                  <td width="20%" align="center">
                    <img alt="" style="padding-top:10px;" src="data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAACCAYAAACZgbYnAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAASSURBVBhXY9DXNHrJICkl+xIAC6ICrTP30AAAAAAASUVORK5CYII=" />
                  </td>
                </xsl:if>
                <td width="60%" align="center" valign="bottom" colspan="2">
                  <table border="0" height="13" id="despatchTable">
                    <tbody>
                      <tr>
                        <td style="width:105px;" align="left">
                          <span style="font-weight:bold;color:#000000; ">
                            <xsl:text>Özelleştirme No:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Customization Number</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td style="width:110px;" align="left">
                          <xsl:for-each select="n1:Invoice/cbc:CustomizationID">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold;color:#000000;  ">
                            <xsl:text>Senaryo:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Scenario</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:ProfileID">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold;color:#000000;  ">
                            <xsl:text>Fatura Tipi:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Type</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:InvoiceTypeCode">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold; color:#000000; ">
                            <xsl:text>Fatura No:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Number</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:ID">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold; color:#000000; ">
                            <xsl:text>Fatura Tarihi:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Date</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:for-each select="n1:Invoice/cbc:IssueDate">
                            <xsl:apply-templates select="." />
                          </xsl:for-each>
                        </td>
                      </tr>
                      <tr style="height:13px; ">
                        <td align="left">
                          <span style="font-weight:bold; color:#000000; ">
                            <xsl:text>Fatura Saati:</xsl:text>
                          </span>
                          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Invoice Time</xsl:text>
                            </span>
                          </xsl:if>
                        </td>
                        <td align="left">
                          <xsl:if test="//n1:Invoice/cbc:IssueTime != '' and //n1:Invoice/cbc:IssueTime != 'null'">
                            <xsl:for-each select="//n1:Invoice/cbc:IssueTime">
                              <xsl:value-of select="substring(.,1,8)" />
                            </xsl:for-each>
                          </xsl:if>
                        </td>
                      </tr>
                      <xsl:for-each select="n1:Invoice/cac:DespatchDocumentReference">
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>İrsaliye No:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Delivery Note</xsl:text>
                              </span>
                            </xsl:if>
                            <xsl:text> </xsl:text>
                          </td>
                          <td align="left">
                            <xsl:value-of select="cbc:ID" />
                          </td>
                        </tr>
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>İrsaliye Tarihi:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Delivery Note Date</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="cbc:IssueDate">
                              <xsl:apply-templates select="." />
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:if test="//n1:Invoice/cac:OrderReference">
                        <tr style="height:13px">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Sipariş No:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Order Number</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="n1:Invoice/cac:OrderReference/cbc:ID">
                              <xsl:apply-templates />
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cac:OrderReference/cbc:IssueDate">
                        <tr style="height:13px">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Sipariş Tarihi:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Order Date</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="n1:Invoice/cac:OrderReference/cbc:IssueDate">
                              <xsl:apply-templates select="." />
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cac:PaymentMeans">
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Son Ödeme Tarihi:</xsl:text>
                            </span>
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Payment Due Date</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:for-each select="n1:Invoice/cac:PaymentMeans">
                              <xsl:for-each select="cbc:PaymentDueDate">
                                <xsl:value-of select="substring(.,9,2)" />-<xsl:value-of select="substring(.,6,2)" />-<xsl:value-of select="substring(.,1,4)" /></xsl:for-each>
                            </xsl:for-each>
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:for-each select="n1:Invoice/cac:TaxRepresentativeParty/cac:PartyIdentification/cbc:ID[@schemeID='ARACIKURUMVKN']">
                        <tr>
                          <td style="width:105px;" align="left">
                            <span style="font-weight:bold;color:#000000;  ">
                              <xsl:text>Aracı Kurum VKN:</xsl:text>
                            </span>
                          </td>
                          <td style="width:110px;" align="left">
                            <xsl:value-of select="." />
                          </td>
                        </tr>
                        <tr>
                          <td style="width:105px;" align="left">
                            <span style="font-weight:bold;color:#000000;  ">
                              <xsl:text>Aracı Kurum Unvan:</xsl:text>
                            </span>
                          </td>
                          <td style="width:110px;" align="left">
                            <xsl:value-of select="../../cac:PartyName/cbc:Name" />
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:if test="contains(.,'#GTB_REFNO:')">
                        <tr style="height:13px; ">
                          <td align="left">
                            <span style="font-weight:bold; color:#000000; ">
                              <xsl:text>Gtb Refno:</xsl:text>
                            </span>
                            <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <br />
                              <xsl:text>Gtb Refno</xsl:text>
                            </span>
                          </td>
                          <td align="left">
                            <xsl:value-of select="substring-before(substring-after(.,'#GTB_REFNO:'),'~;')" />
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="contains(.,'#GTB_GCB_TESCILNO:')">
                        <tr style="height:13px; ">
                          <td align="left">
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-weight:bold; color:#000000; ">
                                <xsl:text>Gtb Gcb Tescil No:</xsl:text>
                              </span>
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Gtb GcbRegistrationNo</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:value-of select="substring-before(substring-after(.,'#GTB_GCB_TESCILNO:'),'~;')" />
                          </td>
                        </tr>
                      </xsl:if>
                      <xsl:if test="contains(.,'#GTB_FIILI_IHRACAT_TARIHI:')">
                        <tr style="height:13px; ">
                          <td align="left">
                            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                              <span style="font-weight:bold; color:#000000; ">
                                <xsl:text>Gtb Fiili İhracat Tarihi:</xsl:text>
                              </span>
                              <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                                <br />
                                <xsl:text>Gtb ActualExportDate</xsl:text>
                              </span>
                            </xsl:if>
                          </td>
                          <td align="left">
                            <xsl:value-of select="substring-before(substring-after(.,'#GTB_FIILI_IHRACAT_TARIHI:'),'~;')" />
                          </td>
                        </tr>
                      </xsl:if>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr align="left">
                <table id="ettnTable">
                  <tr style="height:13px;">
                    <td align="left" valign="top">
                      <span style="font-weight:bold; color:#000000;">
                        <xsl:text>ETTN:</xsl:text>
                      </span>
                    </td>
                    <td align="left" width="240px">
                      <xsl:for-each select="n1:Invoice/cbc:UUID">
                        <xsl:apply-templates />
                      </xsl:for-each>
                    </td>
                  </tr>
                </table>
              </tr>
            </tbody>
          </table>
          <br />
          <div id="lineTableAligner">
            <span>
              <xsl:text> </xsl:text>
            </span>
          </div>
     
          <table border="1" id="lineTable" width="800px">
            <tbody>     
              <tr id="lineTableTr">
                <td id="lineTableTd" style="width:4%;background-color:#000000;color:#fff;">
                  <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                    <xsl:text>S.N</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Q.N</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <xsl:if test="//n1:Invoice//cac:InvoiceLine/cac:Item/cbc:BrandName != ''">
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold; font-size:9px;color:#fff;" align="center">
                      <xsl:text>Marka</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Brand</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cbc:ID != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold;font-size:9px; color:#fff;" align="center">
                        <xsl:text>Ürün Kodu </xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Seller Code</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cbc:ID != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                        <xsl:text>Alıcı Ü. Kodu </xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Buyer Code</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                </xsl:if>
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                    <xsl:text>Mal/Hizmet</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Product</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Açıklama</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Description</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Not</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Note</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                 <td height="25" class="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                   <span style="font-weight:bold;font-size:9px;">
                     <xsl:choose>
                       <xsl:when test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or 
                                       //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE'">
                         <xsl:text>Makine Adı</xsl:text>
                       </xsl:when>
                       <xsl:otherwise>
                         <xsl:text>Model</xsl:text>
                       </xsl:otherwise>
                     </xsl:choose>
                     <br />
                   </span>

                   <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                     <span style="font-size:9px;font-style:italic;">
                       <xsl:text>Model Name</xsl:text>
                     </span>
                   </xsl:if>
                 </td>
               </xsl:if>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:OriginCountry/cbc:Name != ''">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Menşei </xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Origin Country</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:NetWeightMeasure  != '0'">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold;font-size:9px; color:#fff;" align="center">
                        <xsl:text>Net </xsl:text>
                        <br />
                      </span>
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Net</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:GrossWeightMeasure != '0'">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                      <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                        <xsl:text>Brüt </xsl:text>
                        <br />
                      </span>
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Gross</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Kap Adedi</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>N.of Boxes</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Kap Cinsi</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Packaging</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != ''">
                    <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px; ">
                        <xsl:text>Şale</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Punnet</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Palet</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Pallet</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != ''">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold; font-size:9px;">
                        <xsl:text>Parti No</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Part No</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                </xsl:if>
                <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px;">
                    <xsl:text> Miktar</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Quantity</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <td id="lineTableTd" style="background-color:#000000;color:#fff;">
                  <span style="font-weight:bold; font-size:9px; color:#fff;" align="center">
                    <xsl:text>Birim</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Unit</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                    <xsl:text> Fiyat</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Unit Price</xsl:text>
                    </span>
                  </xsl:if>
                </td>
                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:Amount != 0">
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:AllowanceChargeReason != '' ">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold; font-size:9px; ">
                        <xsl:text>İskonto Aciklaması</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Discount Description</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric != 0 ">
                    <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                      <span style="font-weight:bold; font-size:9px; ">
                        <xsl:text>İskonto O.</xsl:text>
                        <br />
                      </span>
                      <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                          <xsl:text>Discount %</xsl:text>
                        </span>
                      </xsl:if>
                    </td>
                  </xsl:if>
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>İskonto T.</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Discount A.</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>

                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount != 0">
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                         <xsl:text>İade Edilen Mal Oranı</xsl:text>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode!='TEVKIFATIADE'">
                         <xsl:text>KDV O.</xsl:text>
                      </xsl:if>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>VAT %</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>KDV Tutarı</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>VAT Amount</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>

                <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode!=0015] or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                  <td id="lineTableTd" style="background-color:#000000;color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Diğer Vergiler</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Other Tax</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
        
         <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Gönd. Şekli</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Sending Form</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px; ">
                      <xsl:text>Gtip No</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Gtip No</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                  <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                      <xsl:text>Teslim Şartı</xsl:text>
                      <br />
                    </span>
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                      <span style="font-size:9px;font-style:italic;">
                        <xsl:text>Delivery Cond.</xsl:text>
                      </span>
                    </xsl:if>
                  </td>
                </xsl:if>
                 
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                         <xsl:text>İadeye Konu İşlem Bedeli</xsl:text>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode!='TEVKIFATIADE'">
                         <xsl:text>Tutar</xsl:text>
                      </xsl:if>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Amount</xsl:text>
                    </span>
                  </xsl:if>
                </td>

           <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px; ">
                     <xsl:text>Tevkifatsız KDV Tutarı</xsl:text>
                    <br />
                  </span>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <span style="font-size:9px;font-style:italic;">
                      <xsl:text>Taxable Amount</xsl:text>
                    </span>
                  </xsl:if>
                </td>
           </xsl:if>

             <xsl:if test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or  //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE' ">
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                      <xsl:text>Harcama Tipi</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="count(//n1:Invoice/cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode) ">
  
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                      <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Makine Teçhizat Sıra No</xsl:text>
                      </span>
                    </td>
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                        <xsl:text>Makine Id</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                </xsl:if>

                 <xsl:for-each select="//cac:InvoiceLine/cac:Item/cac:AdditionalItemIdentification/cbc:ID/@schemeID[ . != 'BIRIM' and not(. = preceding::cbc:ID/@schemeID) ]">
                <td height="25" class="lineTableTd" bgcolor="#000000" style="color:#fff; font-weight:bold; font-size:9px; white-space: nowrap; width: 1%; padding: 0 10px;" align="center">
                    <span style="font-weight:bold;font-size:9px;">
                        <xsl:value-of select="."/>
                        <br/>
                    </span>
                    
                    <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <span style="font-size:9px;font-style:italic;">
                            <xsl:value-of select="."/>
                        </span>
                    </xsl:if>
                </td>
                </xsl:for-each>
                <xsl:for-each select="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:Name[not(. = preceding::cac:AdditionalItemProperty/cbc:Name)]">
                <td height="25" id="lineTableTd" bgcolor="#000000" style="color:#fff;" align="center">
                  <span style="font-weight:bold;font-size:9px;">
                    <xsl:value-of select="." />
                  </span>
                </td>
                </xsl:for-each>
              </tr>
        
        
              <xsl:for-each select="//n1:Invoice/cac:InvoiceLine">
                <tr id="lineTableTr">
                  <td id="lineTableTd" align="center">
                    <xsl:value-of select="./cbc:ID" />
                  </td>
                  <xsl:if test="//n1:Invoice//cac:InvoiceLine/cac:Item/cbc:BrandName != ''">
                    <td id="lineTableTd" align="center">
                      <xsl:value-of select="./cac:Item/cbc:BrandName" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cbc:ID != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cac:SellersItemIdentification/cbc:ID" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cbc:ID != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cac:BuyersItemIdentification/cbc:ID" />
                      </td>
                    </xsl:if>
                  </xsl:if>
                  <td id="lineTableTd" align="left">
                    <xsl:value-of select="./cac:Item/cbc:Name" />
                  </td>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                    <td id="lineTableTd" align="left">
                      <xsl:value-of select="./cac:Item/cbc:Description" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                    <td id="lineTableTd" align="left">
                      <xsl:for-each select="./cbc:Note">
                        <xsl:value-of select="." />
                        <br />
                      </xsl:for-each>
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != '' and //n1:Invoice/cbc:ProfileID != 'IHRACAT' ">
                    <td id="lineTableTd" align="left">
                      <xsl:value-of select="./cac:Item/cbc:ModelName" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:OriginCountry/cbc:Name != ''">
                    <td id="lineTableTd" align="left">
                      <xsl:value-of select="./cac:Item/cac:OriginCountry/cbc:Name" />
                    </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cbc:NetWeightMeasure != '0'">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Delivery/cac:Shipment/cbc:NetWeightMeasure" />
                                     KG
                                 </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cbc:GrossWeightMeasure!= '0'">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Delivery/cac:Shipment/cbc:GrossWeightMeasure" />
                                     KG
                                 </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="format-number(./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity, '###.###,####', 'european')" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine//cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:choose>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '4H'">
                            <xsl:text> P.Cases </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '5H'">
                            <xsl:text> C.Boxes </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '6H'">
                            <xsl:text> W.Cases </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'EC'">
                            <xsl:text> P.Bag </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'SA'">
                            <xsl:text> Sack </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'PJ'">
                            <xsl:text> Punnet </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = '8A'">
                            <xsl:text> Pallet </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'PX'">
                            <xsl:text> Pallet </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'DR'">
                            <xsl:text> Drum </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BK'">
                            <xsl:text> Basket </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'TN'">
                            <xsl:text> Tin </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CT'">
                            <xsl:text> Carton </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BE'">
                            <xsl:text> Bundle </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BG'">
                            <xsl:text> Bag </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BH'">
                            <xsl:text> Bunch </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BI'">
                            <xsl:text> Bin </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BJ'">
                            <xsl:text> Bucket </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'BX'">
                            <xsl:text> Box </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CB'">
                            <xsl:text> Crate,beer </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CH'">
                            <xsl:text> Chest </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CI'">
                            <xsl:text> Canister </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CK'">
                            <xsl:text> Cask </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CN'">
                            <xsl:text> Container </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'CR'">
                            <xsl:text> Crate </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'DK'">
                            <xsl:text> Crate,bulk,cardboard </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'DR'">
                            <xsl:text> Drum </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'FC&#xD;&#xA;                                       '">
                            <xsl:text> Crate,Fruit </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'JR'">
                            <xsl:text> Jar </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'LV'">
                            <xsl:text> Liftvan </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'NE'">
                            <xsl:text> Unpacked or Unpackaged </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'SU'">
                            <xsl:text> Suitcase </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode = 'VG'">
                            <xsl:text> Bulk,gas </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='VL'">
                            <xsl:text> Bulk,liquid </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='VO'">
                            <xsl:text> Bulk,solid </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='BA'">
                            <xsl:text> Barrel </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='EC'">
                            <xsl:text> Bag,plastic </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='5H'">
                            <xsl:text> Bag,woven,plastic </xsl:text>
                          </xsl:when>
                          <xsl:when test="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode ='6H'">
                            <xsl:text> Composite packaging , plastic receptacle </xsl:text>
                          </xsl:when>
              
                          <xsl:otherwise>
              <xsl:value-of select="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode" />
              <xsl:value-of select="./cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode/@name" />
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cbc:Note != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cbc:Note" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:Description != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cbc:Description" />
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Item/cbc:ModelName != ''">
                      <td id="lineTableTd" align="center">
                        <xsl:value-of select="./cac:Item/cbc:ModelName" />
                      </td>
                    </xsl:if>
                  </xsl:if>
                  <td id="lineTableTd" align="center">
                    <xsl:value-of select="format-number(./cbc:InvoicedQuantity, '###.##0,########', 'european')" />
                  </td>
                  <td id="lineTableTd" align="center">
                    <xsl:if test="./cbc:InvoicedQuantity/@unitCode">
                      <xsl:for-each select="./cbc:InvoicedQuantity">
                        <xsl:text>
                        </xsl:text>
                        <xsl:choose>
                          <xsl:when test="@unitCode  = '26'">
                            <xsl:text>Ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'BX'">
                            <xsl:text>Kutu</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'LTR'">
                            <xsl:text>Lt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'C62'">
                            <xsl:text>Adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KGM'">
                            <xsl:text>Kg</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KJO'">
                            <xsl:text>KJ</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'GRM'">
                            <xsl:text>Gram</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MGM'">
                            <xsl:text>Mg</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'NT'">
                            <xsl:text>Net Ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'GT'">
                            <xsl:text>Gross Ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MTR'">
                            <xsl:text>M</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MMT'">
                            <xsl:text>Mm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KTM'">
                            <xsl:text>Km</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MLT'">
                            <xsl:text>Ml</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MMQ'">
                            <xsl:text>Mm3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CLT'">
                            <xsl:text>cl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CMK'">
                            <xsl:text>cm2</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CMQ'">
                            <xsl:text>cm3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CMT'">
                            <xsl:text>cm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MTK'">
                            <xsl:text>m2</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MTQ'">
                            <xsl:text>m3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'DAY'">
                            <xsl:text> Gün</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MON'">
                            <xsl:text> Ay</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'PA'">
                            <xsl:text> Paket</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'KWH'">
                            <xsl:text> KWH</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'ANN'">
                            <xsl:text> Yıl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'HUR'">
                            <xsl:text> Saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'MIN'">
                            <xsl:text> Dakika</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'SEC'">
                            <xsl:text> Saniye</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'CCT'">
                            <xsl:text> Ton baş.taşıma kap.</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'D30'">
                            <xsl:text> Brüt kalori</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'D40'">
                            <xsl:text> 1000 lt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'LPA'">
                            <xsl:text> saf alkol lt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'B32'">
                            <xsl:text> kg.m2</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'NCL'">
                            <xsl:text> hücre adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'PR'">
                            <xsl:text> Çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'R9'">
                            <xsl:text> 1000 m3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'SET'">
                            <xsl:text> Takım</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'T3'">
                            <xsl:text> 1000 adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'SA'">
                            <xsl:text> Çuval</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = '5H'">
                            <xsl:text> C.Boxes</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = '4H'">
                            <xsl:text> P.Cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'BFT'">
                            <xsl:text> W.Cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'EC'">
                            <xsl:text> P.Bag</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode  = 'PJ'">
                            <xsl:text> Punnet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BJ'">
                            <xsl:text> Kova</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='AFF'">
                            <xsl:text> afif birim fiyatı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='AKQ'">
                            <xsl:text> atv birim fiyatı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='AYR'">
                            <xsl:text> altın ayarı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='B32'">
                            <xsl:text> kg-metre kare</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BAS'">
                            <xsl:text> bas</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='C62'">
                            <xsl:text> adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CCT'">
                            <xsl:text> ton başına taşıma kapasitesi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='PR'">
                            <xsl:text> adet-çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='D30'">
                            <xsl:text> brüt kalori değeri</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='D40'">
                            <xsl:text> bin litre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GFI'">
                            <xsl:text> fıssıle izotop gramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GMS'">
                            <xsl:text> gümüş</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GRM'">
                            <xsl:text> gram</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='GT'">
                            <xsl:text> gross ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='H62'">
                            <xsl:text> yüz adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='K20'">
                            <xsl:text> kilogram potasyum oksit</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='K58'">
                            <xsl:text> kurutulmuş net ağırlıklı kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='K62'">
                            <xsl:text> kilogram-adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KFO'">
                            <xsl:text> difosfor pentaoksit kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KGM'">
                            <xsl:text> kilogram</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KH6'">
                            <xsl:text> kilogram-baş</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KHO'">
                            <xsl:text> hidrojen peroksit kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KMA'">
                            <xsl:text> metil aminlerin kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KNI'">
                            <xsl:text> azotun kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KOH'">
                            <xsl:text> kilogram potasyum hidroksit</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KPH'">
                            <xsl:text> kg potasyum oksid</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KPR'">
                            <xsl:text> kilogram-çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KSD'">
                            <xsl:text> kuru ürün kilogramı %90</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KSH'">
                            <xsl:text> sodyum hidroksit kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KUR'">
                            <xsl:text> uranyum kilogramı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KWH'">
                            <xsl:text> kilowatt saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KWT'">
                            <xsl:text> kilowatt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='LPA'">
                            <xsl:text> saf alkol litresi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='LTR'">
                            <xsl:text> litre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MTK'">
                            <xsl:text> metre kare</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MTQ'">
                            <xsl:text> metre küp</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MTR'">
                            <xsl:text> metre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='NCL'">
                            <xsl:text> hücre adedi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='NCR'">
                            <xsl:text> karat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='OMV'">
                            <xsl:text> otv maktu vergi</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='OTB'">
                            <xsl:text> otv birim fiyatı</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='R9'">
                            <xsl:text> bin metre küp</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='T3'">
                            <xsl:text> bin adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TWH'">
                            <xsl:text> bin kilowatt saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DRL'">
                            <xsl:text> rulo</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='26'">
                            <xsl:text> ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SA'">
                            <xsl:text> çuval</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='C68'">
                            <xsl:text> punnet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='4H'">
                            <xsl:text> p.cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='5H'">
                            <xsl:text> c.boxes</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BFT'">
                            <xsl:text> w.cases</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='EC'">
                            <xsl:text> p.bag</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SA'">
                            <xsl:text> sack</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BX'">
                            <xsl:text> kutu</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BO'">
                            <xsl:text> şişe</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SL'">
                            <xsl:text> palet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='SET'">
                            <xsl:text> takım</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='PA'">
                            <xsl:text> paket</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CT'">
                            <xsl:text> karton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='J57'">
                            <xsl:text> varil</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='JOU'">
                            <xsl:text> vardiya</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MON'">
                            <xsl:text> ay</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='HUR'">
                            <xsl:text> saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='D62'">
                            <xsl:text> saniye</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='ANN'">
                            <xsl:text> yıl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DAY'">
                            <xsl:text> gün</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CL'">
                            <xsl:text> bobin</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='E27'">
                            <xsl:text> doz</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='EA'">
                            <xsl:text> ea</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='PK'">
                            <xsl:text> koli</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='ST'">
                            <xsl:text> tbk</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MGM'">
                            <xsl:text> mw</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KF'">
                            <xsl:text> Kilo Paket</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DR'">
                            <xsl:text> bidon</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='1J'">
                            <xsl:text> ton mile</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='HAR'">
                            <xsl:text> hektar</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='LR'">
                            <xsl:text> tabaka</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BJ'">
                            <xsl:text> kova</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DPC'">
                            <xsl:text> düzine parça</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='DPR'">
                            <xsl:text> düzine çift</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='KTM'">
                            <xsl:text> kilometre</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MIN'">
                            <xsl:text> dakika</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MAW'">
                            <xsl:text> megawatt</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MWH'">
                            <xsl:text> megawatt saat</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TL'">
                            <xsl:text> tl</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='WEE'">
                            <xsl:text> hafta</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CMQ'">
                            <xsl:text> cm3</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='MMT'">
                            <xsl:text> mm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TC'">
                            <xsl:text> kamyon</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CH'">
                            <xsl:text> konteynır</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='BG'">
                            <xsl:text> poşet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='ACR'">
                            <xsl:text> dönüm</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TNE'">
                            <xsl:text> ton</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='CR'">
                            <xsl:text> sandık</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='NIU'">
                            <xsl:text> adet</xsl:text>
                          </xsl:when>
                          <xsl:when test="@unitCode='TN'">
                            <xsl:text> teneke</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="@unitCode" />
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:if>
                  </td>
          
                  <td id="lineTableTd" align="center">
                    <xsl:value-of select="format-number(./cac:Price/cbc:PriceAmount, '###.##0,########', 'european')" />
                    <xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID">
                      <xsl:text>
                      </xsl:text>
                      <xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot; or ./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot;">
                        <xsl:text>TL</xsl:text>
                      </xsl:if>
                      <xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot; and ./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot;">
                        <xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID" />
                      </xsl:if>
                    </xsl:if>
                  </td>
          
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:Amount != 0">
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:AllowanceChargeReason != '' ">
                      <td id="lineTableTd" align="center">
                        <xsl:for-each select="./cac:AllowanceCharge">
                          <xsl:value-of select="cbc:AllowanceChargeReason" />
                          <br />
                        </xsl:for-each>
                      </td>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric != 0 ">
                      <td id="lineTableTd" align="center">
                        <xsl:for-each select="./cac:AllowanceCharge">
                          <xsl:if test="cbc:MultiplierFactorNumeric">
                            <xsl:text> %</xsl:text>
                            <xsl:value-of select="format-number(cbc:MultiplierFactorNumeric * 100, '###.##0,########', 'european')" />
                            <br />
                          </xsl:if>
                        </xsl:for-each>
                      </td>
                    </xsl:if>
                    <td id="lineTableTd" align="center">
                      <xsl:for-each select="./cac:AllowanceCharge">
                        <xsl:value-of select="format-number(cbc:Amount, '###.##0,00', 'european')" />
                        <br />
                      </xsl:for-each>
                    </td>
                  </xsl:if>
                 <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount != 0 or (//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA'">
                  <td id="lineTableTd" align="center">
                    <xsl:choose>
                      <xsl:when test="(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA'">
                        <xsl:text>%0,00</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                          <xsl:if test="cbc:TaxTypeCode='0015' ">
                            <xsl:if test="../../cbc:Percent">
                              <xsl:text> %</xsl:text>
                              <xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')" />
                            </xsl:if>
                          </xsl:if>
                        </xsl:for-each>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td id="lineTableTd" align="center">
                    <xsl:choose>
                      <xsl:when test="(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA'">
                        <xsl:text>0,00</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                          <xsl:if test="cbc:TaxTypeCode='0015' ">
                            <xsl:for-each select="../../cbc:TaxAmount">
                              <xsl:call-template name="Curr_Type" />
                            </xsl:for-each>
                          </xsl:if>
                        </xsl:for-each>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode!=0015] or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                    <td id="lineTableTd" align="center">
                      <xsl:text> </xsl:text>
                      <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                        <xsl:if test="cbc:TaxTypeCode!='0015' ">
                          <xsl:text>
                          </xsl:text>
                          <xsl:value-of select="cbc:Name" />
                          <xsl:if test="../../cbc:Percent">
                            <xsl:text> (%</xsl:text>
                            <xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')" />
                            <xsl:text>)=</xsl:text>
                          </xsl:if>
                          <xsl:for-each select="../../cbc:TaxAmount">
                            <xsl:call-template name="Curr_Type" />
                          </xsl:for-each>
                        </xsl:if>
                      </xsl:for-each>
                      <xsl:for-each select="./cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                        <xsl:text>   KDV TEVKİFAT </xsl:text>
                        <xsl:if test="../../cbc:Percent">
                          <xsl:text> (%</xsl:text>
                          <xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')" />
                          <xsl:text>)=</xsl:text>
                        </xsl:if>
                        <xsl:for-each select="../../cbc:TaxAmount">
                          <xsl:call-template name="Curr_Type" />
                          <xsl:text>
                          </xsl:text>
                        </xsl:for-each>
                      </xsl:for-each>
                    </td>
                  </xsl:if>
          
           <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableTd" align="center">
                      <xsl:choose>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '0'">
                          <xsl:text>Transport Mode Not Specified </xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '1'">
                          <xsl:text>BY SHIP</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '2'">
                          <xsl:text>BY TRAIN</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '3'">
                          <xsl:text>BY TRUCK</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '4'">
                          <xsl:text>BY AIRPLANE</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '5'">
                          <xsl:text>Email</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '6'">
                          <xsl:text>Multiple Transportation</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '7'">
                          <xsl:text>Fixed Shipping</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '8'">
                          <xsl:text>Inland Water Transport</xsl:text>
                        </xsl:when>
                        <xsl:when test="./cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode = '9'">
                          <xsl:text>Transport Mode Not Available</xsl:text>
                        </xsl:when>
                      </xsl:choose>
                    </td>
                    <td id="lineTableTd" align="center">
                      <xsl:value-of select="./cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID" />
                    </td>
                    <td id="lineTableTd" align="center">
                      <xsl:value-of select="./cac:Delivery/cac:DeliveryTerms/cbc:ID" />
                      <xsl:if test="./cac:Delivery/cac:DeliveryTerms/cbc:SpecialTerms !=''"> 
                      - <xsl:value-of select="./cac:Delivery/cac:DeliveryTerms/cbc:SpecialTerms" /></xsl:if>
                    </td>
                  </xsl:if>
   
          
                  <td id="lineTableTd" align="right">
                    <xsl:for-each select="cbc:LineExtensionAmount">
                      <xsl:call-template name="Curr_Type" />
                    </xsl:for-each>
                  </td>

                <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                    <td id="lineTableTd" align="center">
                        <xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                          <xsl:if test="cbc:TaxTypeCode='0015' ">
                            <xsl:text>
                            </xsl:text>
                            <xsl:for-each select="../../cbc:TaxableAmount">
                              <xsl:call-template name="Curr_Type" />
                            </xsl:for-each>
                          </xsl:if>
                        </xsl:for-each>
                      </td>
                 </xsl:if>


                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE'">
                <td class="lineTableTd" align="left">
                  <xsl:text>&#160;</xsl:text>
                  <xsl:for-each
                    select="cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode">           
                    <xsl:apply-templates/>
                    <xsl:text>&#160;-&#160;</xsl:text>
                    <xsl:choose>
                      <xsl:when test=". = '01'">
                        <xsl:text>Makine ve teçhizat teslimleri ile yazılım ve gayrimaddi hak satış ve kiralamaları</xsl:text>
                      </xsl:when>
                      <xsl:when test=". = '02'">
                        <xsl:text>İnşaat işlerine ilişkin mal teslimleri ve hizmet ifaları</xsl:text>
                      </xsl:when>
                      <xsl:when test=". = '03'">
                        <xsl:text>Arsa /Arazi Satışları</xsl:text>
                      </xsl:when>
                      <xsl:when test=". = '04'">
                        <xsl:text>Diğer harcamalar </xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:for-each>
                </td>
                <xsl:if test="count(//n1:Invoice/cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode) ">
                  <td class="lineTableTd" align="right">
                    <xsl:text>&#160;</xsl:text>
                    <xsl:for-each
                      select="cac:Item/cac:ItemInstance/cbc:ProductTraceID">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </td>
                  <td class="lineTableTd" align="right">
                    <xsl:text>&#160;</xsl:text>
                    <xsl:for-each
                      select="cac:Item/cac:ItemInstance/cbc:SerialID">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </td>
                </xsl:if>       
              </xsl:if>
              <xsl:variable name="line" select="."/>
              <xsl:for-each select="//cac:InvoiceLine/cac:Item/cac:AdditionalItemIdentification/cbc:ID/@schemeID[ . != 'BIRIM' and not(. = preceding::cbc:ID/@schemeID) ]">
                  <td class="lineTableTd" align="center" style="white-space: nowrap; width: 1%; padding: 0 10px;">
                      <xsl:choose>
                          <xsl:when test="//n1:Invoice/cbc:ProfileID = 'IDIS' and string(current()) = 'ETIKETNO'">
                              <xsl:for-each select="$line/cac:Item/cac:AdditionalItemIdentification/cbc:ID[@schemeID = 'ETIKETNO']">
                                  <xsl:value-of select="."/>
                                  <xsl:if test="position() != last()"><br/></xsl:if>
                              </xsl:for-each>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:value-of select="($line/cac:Item/cac:AdditionalItemIdentification/cbc:ID[@schemeID = string(current())])[1]"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
              </xsl:for-each>
              <xsl:for-each select="//n1:Invoice/cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:Name[not(. = preceding::cac:AdditionalItemProperty/cbc:Name)]">
                <xsl:variable name="customColumnName" select="." />
                <td id="lineTableTd" align="center">
                  <xsl:value-of select="$line/cac:Item/cac:AdditionalItemProperty[cbc:Name = $customColumnName]/cbc:Value" />
                </td>
              </xsl:for-each>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:for-each>
        <table id="budgetContainerTable" style="margin-left:320px;" width="480px">
          <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
            <xsl:if test="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '4171'">
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold;color:#000000;">
                    <xsl:text>Teslim Bedeli</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Delivery Price</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount">
                    <xsl:call-template name="Curr_Type" />
                  </xsl:for-each>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
          <tr id="budgetContainerTr" align="right">
            <td id="budgetContainerDummyTd" />
            <td id="lineTableBudgetTd" align="right" width="210px">
              <span style="font-weight:bold;color:#000000;">
                 <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode='TEVKIFATIADE'">
                       <xsl:text>İadeye Konu İşlem Bedeli Tutarı</xsl:text>
                 </xsl:if>
                 <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode!='TEVKIFATIADE'">
                       <xsl:text>Mal/Hizmet Toplam Tutarı</xsl:text>
                 </xsl:if>
              </span>
            </td>
            <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
              <td id="lineTableBudgetTd" align="left" width="180px">
                <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                  <xsl:text>  Goods/Service Total Amount</xsl:text>
                </span>
              </td>
            </xsl:if>
            <td id="lineTableBudgetTd" style="width:90px; " align="right">
              <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount">
                <xsl:call-template name="Curr_Type" />
              </xsl:for-each>
            </td>
          </tr>

          <xsl:if test="n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !=0">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" align="right" width="210px">
                <span style="font-weight:bold;color:#000000;">
                  <xsl:text>Toplam İskonto</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" align="left" width="180px">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Total Discount</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
          <xsl:if test="not(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') and //n1:Invoice/cbc:InvoiceTypeCode != 'YTBISTISNA'">
          <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold;color:#000000; ">
                  <xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name" />
                  <xsl:text>(</xsl:text>
                  <xsl:value-of select="format-number(cbc:TaxableAmount, '###.##0,00', 'european')" />
                  <xsl:text> %</xsl:text>
                  <xsl:value-of select="cbc:Percent" />
                  <xsl:text>)</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Tax Percent</xsl:text>
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="cbc:Percent" />
                    <xsl:text>%)</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
                  <xsl:text>
                  </xsl:text>
                  <xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')" />
                  <xsl:if test="../../cbc:TaxAmount/@currencyID">
                    <xsl:text>
                    </xsl:text>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRL' or ../../cbc:TaxAmount/@currencyID = 'TRY'">
                      <xsl:text>TL</xsl:text>
                    </xsl:if>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRL' and ../../cbc:TaxAmount/@currencyID != 'TRY'">
                      <xsl:value-of select="../../cbc:TaxAmount/@currencyID" />
                    </xsl:if>
                  </xsl:if>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
           </xsl:if>
    <xsl:for-each select="n1:Invoice/cac:AllowanceCharge">
         <xsl:if test="cbc:Amount !=0 and cbc:AllowanceChargeReason !=''">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold;color:#000000; ">
                  <xsl:value-of select="cbc:AllowanceChargeReason" />
                  <xsl:text>(</xsl:text>
                  <xsl:value-of select="format-number(cbc:BaseAmount, '###.##0,00', 'european')" />
                  <xsl:text> %</xsl:text>
                  <xsl:value-of select="cbc:MultiplierFactorNumeric" />
                  <xsl:text>)</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text> Tax Percent</xsl:text>
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="cbc:MultiplierFactorNumeric" />
                    <xsl:text>%)</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <xsl:text>
                    </xsl:text>
                    <xsl:value-of select="format-number(cbc:Amount, '###.##0,00', 'european')" />
                    <xsl:if test="cbc:Amount/@currencyID">
                      <xsl:text>
                      </xsl:text>
                      <xsl:if test="cbc:Amount/@currencyID = 'TRL' or cbc:Amount/@currencyID = 'TRY'">
                        <xsl:text>TL</xsl:text>
                      </xsl:if>
                      <xsl:if test="cbc:Amount/@currencyID != 'TRL' and cbc:Amount/@currencyID != 'TRY'">
                        <xsl:value-of select="cbc:Amount/@currencyID" />
                      </xsl:if>
                    </xsl:if>              
              </td>
            </tr>
       </xsl:if>
     </xsl:for-each>

          <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
            <xsl:if test="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '4171'">
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>KDV Matrahı</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  VAT Basis</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(sum(//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=0015]/cbc:TaxableAmount), '###.##0,00', 'european')" />
                  <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID">
                    <xsl:text>
                    </xsl:text>
                    <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID = 'TRL' or //n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID = 'TRY'">
                      <xsl:text>TL</xsl:text>
                    </xsl:if>
                    <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID != 'TRL' and //n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID != 'TRY'">
                      <xsl:value-of select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID" />
                    </xsl:if>
                  </xsl:if>
                </td>
              </tr>
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Tevkifat Dahil Toplam Tutar</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Total Amount Including Withholding</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
                    <xsl:call-template name="Curr_Type" />
                  </xsl:for-each>
                </td>
              </tr>
              <tr id="budgetContainerTr" align="right">
                <td id="budgetContainerDummyTd" />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Tevkifat Hariç Toplam Tutar</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Total Amount Excluding Withholding</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
                    <xsl:call-template name="Curr_Type" />
                  </xsl:for-each>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Hesaplanan KDV Tevkifat</xsl:text>
                  <xsl:text>(%</xsl:text>
                  <xsl:value-of select="cbc:Percent" />
                  <xsl:text>)</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Reverse Charge Output VAT </xsl:text>
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="cbc:Percent" />
                    <xsl:text>%)</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
                  <xsl:text>
                  </xsl:text>
                  <xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')" />
                  <xsl:if test="../../cbc:TaxAmount/@currencyID">
                    <xsl:text>
                    </xsl:text>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRL' or ../../cbc:TaxAmount/@currencyID = 'TRY'">
                      <xsl:text>TL</xsl:text>
                    </xsl:if>
                    <xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRL' and ../../cbc:TaxAmount/@currencyID != 'TRY'">
                      <xsl:value-of select="../../cbc:TaxAmount/@currencyID" />
                    </xsl:if>
                  </xsl:if>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>

          <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Sigorta Tutarı</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Insurance Total</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:value-of select="format-number(sum(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount), '###.##0,00', 'european')" />
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text> TL</xsl:text>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                </xsl:if>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Navlun Tutarı</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Freight Total</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:value-of select="format-number(sum(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount), '###.##0,00', 'european')" />
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text> TL</xsl:text>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                </xsl:if>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:FreeOnBoardValueAmount">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:value-of select="substring-before(substring-after(.,'#AÇIKLAMA:'),'~;')" />
                </span>
              </td>
              <td id="lineTableBudgetTd" width="180px" align="left">
                <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                </span>
              </td>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:value-of select="format-number(sum(//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cbc:FreeOnBoardValueAmount), '###.##0,00', 'european')" />
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text> TL</xsl:text>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                </xsl:if>
              </td>
            </tr>
          </xsl:if>

          <!-- <xsl:if test="contains(.,'#NAVLUN:')">
                  <tr id="budgetContainerTr" align="right">
                     <td id="budgetContainerDummyTd"/>
                     <td id="lineTableBudgetTd" width="210px" align="right">
                        <span style="font-weight:bold; color:#000000;">
                           <xsl:text>Navlun Tutarı</xsl:text>
                        </span>
                     </td>
                     <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <td id="lineTableBudgetTd" width="180px" align="left">
                           <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <xsl:text>&#160;&#160;Freight Total</xsl:text>
                           </span>
                        </td>
                     </xsl:if>
                     <td id="lineTableBudgetTd" style="width:90px; " align="right">
                        <xsl:value-of select="substring-before(substring-after(.,'#NAVLUN:'),'~;')"/>
                        &#160;
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                           <xsl:text>TL</xsl:text>
                        </xsl:if>
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                           <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                        </xsl:if>
                     </td>
                  </tr>
               </xsl:if>-->
          <!-- <xsl:if test="contains(.,'#SIGORTA:')">
                  <tr id="budgetContainerTr" align="right">
                     <td id="budgetContainerDummyTd"/>
                     <td id="lineTableBudgetTd" width="210px" align="right">
                        <span style="font-weight:bold; color:#000000;">
                           <xsl:text>Sigorta Tutarı</xsl:text>
                        </span>
                     </td>
                     <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                        <td id="lineTableBudgetTd" width="180px" align="left">
                           <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                              <xsl:text>&#160;&#160;Insurance Total</xsl:text>
                           </span>
                        </td>
                     </xsl:if>
                     <td id="lineTableBudgetTd" style="width:90px; " align="right">
                        <xsl:value-of select="substring-before(substring-after(.,'#SIGORTA:'),'~;')"/>
                        &#160;
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                           <xsl:text>TL</xsl:text>
                        </xsl:if>
                        <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                           <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                        </xsl:if>
                     </td>
                  </tr>
               </xsl:if> -->

          <xsl:if test="n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount !=0">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" align="right" width="210px">
                <span style="font-weight:bold;color:#000000;">
                  <xsl:text>Toplam Masraf</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" align="left" width="180px">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text> Charge Total Amount</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="//n1:Invoice/cbc:ProfileID != 'IHRACAT'">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Vergiler Dahil Toplam Tutar</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Total Amount Including Taxes</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>Ödenecek Tutar</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Amount To Be Paid</xsl:text>
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
            <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
              <tr align="right">
                <td />
                <td id="lineTableBudgetTd" width="210px" align="right">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Döviz Kuru</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" width="180px" align="left">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Exchange Rate</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,0000', 'european')" />
                  <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                    <xsl:text> TL</xsl:text>
                  </xsl:if>
                  <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                                  
                                 <xsl:value-of select="//n1:Invoice/cbc:DocumentCurrencyCode" /></xsl:if>
                </td>
              </tr>
              <tr align="right">
                <td />
                <td id="lineTableBudgetTd" align="right" width="210px">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Mal Hizmet Toplam Tutarı(TL)</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" align="left" width="180px">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Goods/Service Total Amount(TL)</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                  <xsl:text> TL</xsl:text>
                </td>
              </tr>
              <xsl:if test="n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !=0">
                <tr id="budgetContainerTr" align="right">
                  <td id="budgetContainerDummyTd" />
                  <td id="lineTableBudgetTd" align="right" width="210px">
                    <span style="font-weight:bold;color:#000000;">
                      <xsl:text>Toplam İskonto (TL)</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableBudgetTd" align="left" width="180px">
                      <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                        <xsl:text>  Total Discount (TL)</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                    <xsl:text> TL</xsl:text>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="not(//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' and //n1:Invoice/cbc:InvoiceTypeCode = 'ISTISNA') and //n1:Invoice/cbc:InvoiceTypeCode != 'YTBISTISNA'">
              <xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
                <tr align="right">
                  <td />
                  <td id="lineTableBudgetTd" align="right" width="210px">
                    <span style="font-weight:bold; color:#000000;">
                      <xsl:text>Hesaplanan </xsl:text>
                      <xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name" />
                      <xsl:text>(%</xsl:text>
                      <xsl:value-of select="cbc:Percent" />
                      <xsl:text>) (TL)</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableBudgetTd" align="left" width="180px">
                      <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                        <xsl:text>  Tax Percent</xsl:text>
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="cbc:Percent" />
                        <xsl:text>%) (TL)</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <span>
                      <xsl:value-of select="format-number(cbc:TaxAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                      <xsl:text> TL</xsl:text>
                    </span>
                  </td>
                </tr>
              </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal">
                <tr id="budgetContainerTr" align="right">
                  <td id="budgetContainerDummyTd" />
                  <td id="lineTableBudgetTd" width="210px" align="right">
                    <span style="font-weight:bold; color:#000000;">
                      <xsl:text>Hesaplanan KDV Tevkifat </xsl:text>
                      <xsl:text>(%</xsl:text>
                      <xsl:value-of select="cbc:Percent" />
                      <xsl:text>) (TL)</xsl:text>
                    </span>
                  </td>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                    <td id="lineTableBudgetTd" width="180px" align="left">
                      <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                        <xsl:text>  Reverse Charge Output VAT </xsl:text>
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="cbc:Percent" />
                        <xsl:text>%)</xsl:text>
                      </span>
                    </td>
                  </xsl:if>
                  <td id="lineTableBudgetTd" style="width:90px; " align="right">
                    <xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
                      <xsl:text>
                      </xsl:text>
                      <xsl:value-of select="format-number(../../cbc:TaxAmount   * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate , '###.##0,00', 'european')" />
                      <xsl:text> TL</xsl:text>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
            </xsl:if>
            <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID != 'TRL' and //n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID != 'TRY'">
              <tr id="budgetContainerTr" align="right">
                <td />
                <td id="lineTableBudgetTd" width="210px" align="right">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Vergiler Dahil Toplam Tutar(TL)</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" width="180px" align="left">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Total Amount Including Taxes(TL)</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                  <xsl:text> TL</xsl:text>
                </td>
              </tr>
              <tr align="right">
                <td />
                <td id="lineTableBudgetTd" width="210px" align="right">
                  <span style="font-weight:bold; color:#000000;">
                    <xsl:text>Ödenecek Tutar(TL)</xsl:text>
                  </span>
                </td>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                  <td id="lineTableBudgetTd" width="180px" align="left">
                    <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                      <xsl:text>  Amount To Be Paid(TL)</xsl:text>
                    </span>
                  </td>
                </xsl:if>
                <td id="lineTableBudgetTd" style="width:90px; " align="right">
                  <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')" />
                  <xsl:text> TL</xsl:text>
                </td>
              </tr>
            </xsl:if>
          </xsl:if>
          <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd" />
              <td id="lineTableBudgetTd" width="210px" align="right">
                <span style="font-weight:bold; color:#000000;">
                  <xsl:text>  Toplam Tutar</xsl:text>
                </span>
              </td>
              <xsl:if test="//n1:Invoice/cbc:ProfileID = 'IHRACAT'">
                <td id="lineTableBudgetTd" width="180px" align="left">
                  <span style="font-size:10px;font-style:italic;color:#808080;font-family: Arial, Helvetica, sans-serif;">
                    <xsl:text>  Total </xsl:text>
                    <xsl:value-of select="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryTerms/cbc:ID" />
                  </span>
                </td>
              </xsl:if>
              <td id="lineTableBudgetTd" style="width:90px; " align="right">
                <xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
                  <xsl:call-template name="Curr_Type" />
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
        </table>
        <xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode = 'SGK'">
          <table border="1" width="250px" style="font-size: 10px; font-weight: bold">
            <tr>
              <td>İlave Fatura Tipi</td>
              <td>
                <xsl:value-of select="//n1:Invoice/cbc:AccountingCost" />
              </td>
            </tr>
            <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
              <xsl:if test="cbc:DocumentTypeCode = 'MUKELLEF_KODU'">
                <tr>
                  <td>
                    <xsl:value-of select="cbc:DocumentDescription" />
                  </td>
                  <td>
                    <xsl:value-of select="cbc:DocumentType" />
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
              <xsl:if test="cbc:DocumentTypeCode = 'MUKELLEF_ADI'">
                <tr>
                  <td>
                    <xsl:value-of select="cbc:DocumentDescription" />
                  </td>
                  <td>
                    <xsl:value-of select="cbc:DocumentType" />
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
              <xsl:if test="cbc:DocumentTypeCode = 'DOSYA_NO'">
                <tr>
                  <td>
                    <xsl:value-of select="cbc:DocumentDescription" />
                  </td>
                  <td>
                    <xsl:value-of select="cbc:DocumentType" />
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
            <xsl:if test="//n1:Invoice/cac:InvoicePeriod">
              <td colspan="2">
                     Dönem :  <xsl:value-of select="//n1:Invoice/cac:InvoicePeriod/cbc:StartDate" />  |  <xsl:value-of select="//n1:Invoice/cac:InvoicePeriod/cbc:EndDate" /></td>
            </xsl:if>
          </table>
        </xsl:if>
        <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampBase64">
          <table align="right" border="0" width="800px">
            <tr>
              <td align="right">
                <xsl:choose>
                  <xsl:when test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampWidthPx or //n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampHeightPx">
                    <img alt="">
                      <xsl:attribute name="src">
                        <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampBase64" />
                      </xsl:attribute>
                      <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampWidthPx">
                        <xsl:attribute name="width">
                          <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampWidthPx" />
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampHeightPx">
                        <xsl:attribute name="height">
                          <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampHeightPx" />
                        </xsl:attribute>
                      </xsl:if>
                    </img>
                  </xsl:when>
                  <xsl:otherwise>
                    <img alt="" style="max-width:140px;max-height:140px;">
                      <xsl:attribute name="src">
                        <xsl:value-of select="//n1:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/app:InvoiceAppExtension/app:Branding/app:StampBase64" />
                      </xsl:attribute>
                    </img>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
            </tr>
          </table>
        </xsl:if>
        <table id="notesTable" width="800px" height="100">
          <tbody>
            <tr align="left">
              <td id="notesTableTd">
                <xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
                  <xsl:if test=" cac:TaxCategory/cbc:TaxExemptionReasonCode !='' ">
                    <b>      Vergi İstisna Muafiyet Sebebi: </b>
                    <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReasonCode" />
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason" />
                    <br />
                  </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="//n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
                  <b>      Tevkifat Sebebi: </b>
                  <xsl:value-of select="cbc:TaxTypeCode" />
                  <xsl:text>-</xsl:text>
                  <xsl:value-of select="cbc:Name" />
                  <br />
                </xsl:for-each>
                  <xsl:if test="//n1:Invoice/cbc:ProfileID = 'YATIRIMTESVIK' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBISTISNA' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBSATIS' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBIADE' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFAT' or //n1:Invoice/cbc:InvoiceTypeCode = 'YTBTEVKIFATIADE'">
                  <b>      Yatırım Teşvik No: </b>
                  <xsl:value-of select="//n1:Invoice/cac:ContractDocumentReference/cbc:ID[@schemeID = 'YTBNO']"/>
                  <br/>
                   <b>      Yatırım Teşvik Tarihi: </b>
                  <xsl:value-of select="//n1:Invoice/cac:ContractDocumentReference[cbc:ID[@schemeID = 'YTBNO']]/cbc:IssueDate"/>
                  <br/>
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate !=0 and //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate !=1">
                  <b>
                                   
                              <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode" />
                              Döviz Kuru: 
                           </b>
                  <xsl:value-of select="format-number(//n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,0000', 'european')" />
                  <br />
                </xsl:if>
                <b>
                </b>
                <xsl:for-each select="//n1:Invoice/cbc:Note">
                  <xsl:if test="not(contains(.,'#GTB_REFNO:'))">
                    <xsl:if test="not(contains(.,'#AÇIKLAMA:'))">
                      <xsl:if test="not(contains(.,'#NAVLUN:'))">
                        <xsl:if test="not(contains(.,'#SIGORTA:'))">
                          <xsl:if test=".">
                            <b>     </b>
                            <xsl:value-of select="." />
                            <br />
                          </xsl:if>
                        </xsl:if>
                      </xsl:if>
                    </xsl:if>
                  </xsl:if>
                </xsl:for-each>
                
                <xsl:if test="(//n1:Invoice/cac:PaymentMeans)[1]/cbc:InstructionNote">
                  <b>      Ödeme Notu: </b>
                  <xsl:value-of select="(//n1:Invoice/cac:PaymentMeans)[1]/cbc:InstructionNote" />
                  <br />
                </xsl:if>
                <xsl:if test="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:ID">
                  <b>      Ödeme İban: </b>
                  <xsl:value-of select="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:ID" />
                  <br />
                </xsl:if>
                <xsl:if test="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:PaymentNote">
                  <b>      Hesap Açıklaması: </b>
                  <xsl:value-of select="(//n1:Invoice/cac:PaymentMeans)[1]/cac:PayeeFinancialAccount/cbc:PaymentNote" />
                  <br />
                </xsl:if>
                <xsl:if test="count(//n1:Invoice/cac:PaymentMeans) &gt; 1">
                  <b>      Diğer Hesaplar: </b>
                  <xsl:for-each select="//n1:Invoice/cac:PaymentMeans[position() &gt; 1]">
                    <br />      <xsl:value-of select="cac:PayeeFinancialAccount/cbc:PaymentNote" /><xsl:text> - </xsl:text><xsl:value-of select="cac:PayeeFinancialAccount/cbc:ID" />
                  </xsl:for-each>
                  <br />
                </xsl:if>
                <xsl:if test="//n1:Invoice/cac:PaymentTerms/cbc:Note">
                  <b>      Ödeme Koşulu: </b>
                  <xsl:value-of select="//n1:Invoice/cac:PaymentTerms/cbc:Note" />
                  <br />
                </xsl:if>
        
               <!-- <xsl:if test="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID">
                  <b>      İade Fatura No: </b>
                  <xsl:value-of select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID" />
                  <br />
                  <b>      İade Fatura Tarih: </b>
                  <xsl:value-of select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:IssueDate" />
                  <br />
                </xsl:if> -->
        
                <xsl:if test="//n1:Invoice/cac:AdditionalDocumentReference[cbc:ID='HideDespatchMessage']">
                  <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                    <xsl:if test="cbc:ID = 'HideDespatchMessage' and cbc:DocumentType = 'false'">
                      <xsl:if test="not(//n1:Invoice/cac:DespatchDocumentReference/cbc:ID and //n1:Invoice/cac:DespatchDocumentReference/cbc:IssueDate)">
                        <tr align="left">
                          <td>
                            <b>      İrsaliye yerine geçer. </b>
                          </td>
                        </tr>
                      </xsl:if>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="not(//n1:Invoice/cac:AdditionalDocumentReference[cbc:ID='HideDespatchMessage'])">
                  <xsl:if test="not(//n1:Invoice/cac:DespatchDocumentReference/cbc:ID and //n1:Invoice/cac:DespatchDocumentReference/cbc:IssueDate)">
                    <tr align="left">
                      <td>
                        <b>      İrsaliye yerine geçer. </b>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:if>
        <xsl:if test="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentTypeCode[text() = 'İADE' or text() = 'IADE']">
          <table id="lineTable" width="800"> 
            <tbody>
              <tr align="left" class="lineTableTr">
                <td class="lineTableTd">
                  <span style="font-weight:bold; " align="center">İade Fatura No</span>
                </td>
                <td class="lineTableTd">
                  <span style="font-weight:bold; " align="center">İade İade Tarihi</span>
                </td>
              </tr>
              <xsl:for-each select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentTypeCode[text() = 'İADE' or text() = 'IADE']">
                <tr align="left" class="lineTableTr">
                  <td class="lineTableTd">
                    <xsl:value-of select="../cbc:ID"/>
                  </td>
                  <td class="lineTableTd"> 
                  <xsl:for-each select="../cbc:IssueDate">
                      <xsl:apply-templates select="."/>
                  </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:if>
                <xsl:if test="//n1:Invoice/cbc:ProfileID = 'EARSIVFATURA'">
                  <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                    <xsl:if test="cbc:ID = 'IsInternetSale' and cbc:DocumentType = 'true'">
                      <table class="eArchiveDetailTable" id="lineTable" width="800" height="50" border="1px">
                        <tr align="center">
                          <td style="font-weight:bold; color:#000000;" colspan="2">
                            <b>DİĞER DETAY BİLGİLER</b>
                          </td>
                        </tr>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Web Sitesi:</b></td>
                          <td>                 
                                 <xsl:value-of select="//n1:Invoice/cac:AdditionalDocumentReference/cac:IssuerParty/cbc:WebsiteURI" /></td>
                        </tr>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Ödeme Şekli:</b></td>
                          <td>
                            <xsl:for-each select="//n1:Invoice/cac:PaymentMeans">
                              <xsl:if test="cbc:PaymentMeansCode = 1"> ODEMEARACISI</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 10"> KAPIDAODEME</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 30"> EFT/HAVALE</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 48"> KREDIKARTI/BANKAKARTI</xsl:if>
                              <xsl:if test="cbc:PaymentMeansCode = 97">
                                                 DIGER - 
                                                <xsl:value-of select="cbc:InstructionNote" /></xsl:if>
                            </xsl:for-each>
                          </td>
                        </tr>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Ödeme Tarihi:</b></td>
                          <td>
                            <xsl:for-each select="//n1:Invoice/cac:PaymentMeans/cbc:PaymentDueDate">
                                              
                                             <xsl:apply-templates select="." /></xsl:for-each>
                          </td>
                        </tr>
                        <xsl:if test="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı TCKN:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='TCKN']" /></td>
                          </tr>
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı Adı / Soyadı:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:Person/cbc:FirstName" />
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:Person/cbc:FamilyName" /></td>
                          </tr>
                        </xsl:if>
                        <xsl:if test="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı VKN:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification/cbc:ID[@schemeID='VKN']" /></td>
                          </tr>
                          <tr>
                            <td style="font-weight:bold; color:#000000;"> <b>Gönderi Taşıyıcı Ünvanı:</b></td>
                            <td>
                                              
                                             <xsl:value-of select="//n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyName/cbc:Name" /></td>
                          </tr>
                        </xsl:if>
                        <tr>
                          <td style="font-weight:bold; color:#000000;"> <b>Gönderim / Hizmet İfa Tarihi:</b></td>
                          <td>
                            <xsl:for-each select="//n1:Invoice/cac:Delivery/cac:Despatch/cbc:ActualDespatchDate">
                                              
                                             <xsl:apply-templates select="." /></xsl:for-each>
                          </td>
                        </tr>
                      </table>
                    </xsl:if>
                  </xsl:for-each>
                  <table class="eArchiveTable" id="lineTable" width="800" height="50">
                    <tbody>
                      <tr align="left">
                        <td>
                          <b>   e-Arşiv İzni Kapsamında Üretilmiştir.</b>
                        </td>
                      </tr>
                      <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                        <xsl:if test="cbc:ID = 'IsInternetSale' and cbc:DocumentType = 'true'">
                          <tr align="left">
                            <td>
                              <b>  Bu satış internet üzerinden yapılmıştır.</b>
                            </td>
                          </tr>
                        </xsl:if>
                      </xsl:for-each>
                      <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                        <xsl:if test="cbc:ID = 'SendType' and cbc:DocumentType = 'ELEKTRONIK'">
                          <tr align="left">
                            <td>
                              <b>  e-Arşiv izni kapsamında elektronik ortamda iletilmiştir.</b>
                            </td>
                          </tr>
                        </xsl:if>
                      </xsl:for-each>
                    </tbody>
                  </table>
                  <xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
                    <xsl:if test="cbc:ID = 'IsInternetSale' and cbc:DocumentType = 'true'">
                      <table class="eArchiveReturnTable" id="lineTable" width="800" height="50" border="1px">
                        <tbody>
                          <tr align="center">
                            <td style="font-weight:bold; color:#000000;">
                              <b>İADE BÖLÜMÜ</b>
                              <br />
                            </td>
                          </tr>
                          <tr align="left">
                            <td style="font-weight:bold; color:#000000;">
                              <b>      <u>İade Edenin;</u></b>
                              <br />
                              <b>      Adı Soyadı:</b>
                              <br />
                              <b>      Adresi:</b>
                              <br />
                              <b>      İmza:</b>
                              <br />
                            </td>
                          </tr>
                          <tr style="font-weight:bold; color:#000000;" align="left">
                            <td style="font-weight:bold; color:#000000;">
                              <table width="100%" align="center" border="1px">
                                <tbody>
                                  <tr style="font-weight:bold; color:#000000;" align="center" height="20">
                                    <td>
                                      <b>İade Edilen Malın Cinsi</b>
                                    </td>
                                    <td>
                                      <b>Miktar</b>
                                    </td>
                                    <td>
                                      <b>Birim Fiyat</b>
                                    </td>
                                    <td>
                                      <b>Tutar</b>
                                    </td>
                                  </tr>
                                  <tr align="center">
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                  </tr>
                                  <tr align="center">
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                  </tr>
                                </tbody>
                              </table>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:if>
                <table border="1" width="800px" id="bankingTable" style="font-size: 10px; font-weight: bold">
                  <caption style="text-align: left; padding: px"></caption>
          
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="//cbc:IssueDate">
    <xsl:value-of select="substring(.,9,2)" />
      -
      <xsl:value-of select="substring(.,6,2)" />
      -
      <xsl:value-of select="substring(.,1,4)" /></xsl:template>
  <xsl:template match="//n1:Invoice">
    <tr id="lineTableTr">
      <td id="lineTableTd">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
      <td id="lineTableTd" align="right">
        <xsl:text> </xsl:text>
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="Party_Title">
    <xsl:param name="PartyType" />
    <td style="width:469px; " align="left">
      <xsl:if test="cac:PartyIdentification/cbc:ID[@schemeID='VKN']">
        <xsl:if test="cac:PartyName">
          <b>
            <xsl:value-of select="cac:PartyName/cbc:Name" />
          </b>
        </xsl:if>
      </xsl:if>
      <xsl:if test="cac:PartyIdentification/cbc:ID[@schemeID='TCKN']">
        <b>
          <xsl:for-each select="cac:Person">
            <xsl:for-each select="cbc:FirstName">
              <xsl:apply-templates />
              <xsl:text> </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="cbc:FamilyName">
              <xsl:apply-templates />
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </xsl:for-each>
        </b>
      </xsl:if>
    </td>
  </xsl:template>
  <xsl:template name="Party_Adress">
    <xsl:param name="PartyType" />
    <td style="width:469px; " align="left">
      <xsl:for-each select="cac:PostalAddress">
        <xsl:for-each select="cbc:StreetName">
          <xsl:apply-templates />
          <xsl:text> </xsl:text>
        </xsl:for-each>
        <xsl:for-each select="cbc:BuildingName">
          <xsl:apply-templates />
        </xsl:for-each>
          <xsl:for-each select="cbc:BuildingNumber">
               <xsl:text> No:</xsl:text>
               <xsl:apply-templates/>
               <xsl:text>&#160;</xsl:text>
            </xsl:for-each>
            <br/>  
          <xsl:for-each select="cbc:Room">
               <xsl:text>Kapı No:</xsl:text>
               <xsl:apply-templates/>
               <xsl:text>&#160;</xsl:text>
            </xsl:for-each>
            <br/>  
        <xsl:for-each select="cbc:PostalZone">
          <xsl:apply-templates />
          <xsl:text> </xsl:text>
        </xsl:for-each>
        <xsl:if test="cbc:CitySubdivisionName !=''&#xD;&#xA;                  and  cbc:CitySubdivisionName !='-'">
          <xsl:for-each select="cbc:CitySubdivisionName">
            <xsl:apply-templates />
            <xsl:text>/ </xsl:text>
          </xsl:for-each>
        </xsl:if>
        <xsl:if test="cbc:CityName !=''&#xD;&#xA;                   and  cbc:CityName !='-'">
          <xsl:for-each select="cbc:CityName">
            <xsl:apply-templates />
            <xsl:text> </xsl:text>
          </xsl:for-each>
        </xsl:if>
        
          <br />
          <xsl:value-of select="cac:Country/cbc:Name" />
          <br />
     
      </xsl:for-each>
    </td>
  </xsl:template>
  <xsl:template name="Party_Other">
    <xsl:param name="PartyType" />
    <xsl:for-each select="cbc:WebsiteURI">
      <tr align="left">
        <td>
          <xsl:text>Web Sitesi: </xsl:text>
          <xsl:value-of select="." />
        </td>
      </tr>
    </xsl:for-each>
    <xsl:for-each select="cac:Contact/cbc:ElectronicMail">
      <tr align="left">
        <td>
          <xsl:text>E-Posta: </xsl:text>
          <xsl:value-of select="." />
        </td>
      </tr>
    </xsl:for-each>
    <xsl:for-each select="cac:Contact">
      <xsl:if test="cbc:Telephone or cbc:Telefax">
        <tr align="left">
          <td style="width:469px; " align="left">
            <xsl:for-each select="cbc:Telephone">
              <xsl:text>Tel: </xsl:text>
              <xsl:apply-templates />
            </xsl:for-each>
            <xsl:for-each select="cbc:Telefax">
              <xsl:text> Fax: </xsl:text>
              <xsl:apply-templates />
            </xsl:for-each>
            <xsl:text> </xsl:text>
          </td>
        </tr>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="$PartyType!='TAXFREE'">
      <xsl:for-each select="cac:PartyTaxScheme/cac:TaxScheme/cbc:Name">
        <tr align="left">
          <td>
            <xsl:text>Vergi Dairesi: </xsl:text>
            <xsl:apply-templates />
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="cac:PartyIdentification">
        <tr align="left">
          <td>
            <xsl:value-of select="cbc:ID/@schemeID" />
            <xsl:text>: </xsl:text>
            <xsl:value-of select="cbc:ID" />
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="Curr_Type">
    <xsl:value-of select="format-number(., '###.##0,00', 'european')" />
    <xsl:if test="@currencyID">
      <xsl:text>
      </xsl:text>
      <xsl:choose>
        <xsl:when test="@currencyID = 'TRL' or @currencyID = 'TRY'">
          <xsl:text>TL</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@currencyID" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>