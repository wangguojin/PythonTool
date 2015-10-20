Shader "Custom/BlendTerrian" {
	Properties {
		_MainBlendTex ("BlendTex",2D) = "white"{}
		_RBlendTex ("R Tex",2D) = "white"{}
		_GBlendTex ("G Tex",2D) = "white"{}
		_BBlendTex ("B Tex",2D) = "white"{}
		_ABlendTex ("A Tex",2D) = "white"{}
		_ColorA ("Color",Color) = (1,1,1,1)
		_ColorB ("Color",Color) = (1,1,1,1)
		_MainTint ("ColorTint",Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _RBlendTex;
		sampler2D _GBlendTex;
		sampler2D _BBlendTex;
		sampler2D _ABlendTex;
		sampler2D _MainBlendTex;
		float4	  _ColorA;
		float4	  _ColorB;
		float4    _MainTint;
		
		struct Input {
			float2 		uv_MainBlendTex;
			float2   	uv_RBlendTex;
			float2  	uv_GBlendTex;
			float2  	uv_BBlendTex;
			float2  	uv_ABlendTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 cBlendMain = tex2D (_MainBlendTex, IN.uv_MainBlendTex);
			half4 cRBlend 	 = tex2D (_RBlendTex,IN.uv_RBlendTex);
			half4 cGBlend	 = tex2D (_GBlendTex,IN.uv_GBlendTex);
			half4 cBBlend    = tex2D (_BBlendTex,IN.uv_BBlendTex);
			half4 cABlend	 = tex2D (_ABlendTex,IN.uv_ABlendTex);
			
			half4 cout = lerp(cRBlend,cGBlend,cBlendMain.g);
			cout = lerp(cout,cBBlend,cBlendMain.b);
			cout = lerp(cout,cABlend,cBlendMain.a);
			cout.a = 1.0;
			float4 cab = lerp(_ColorA,_ColorB,cBlendMain.r);
			cab = saturate(cab * cout);
			o.Albedo = cab.rgb * _MainTint.rgb;
			o.Alpha = cout.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
