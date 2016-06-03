//
//  IDZSwiftModelIO.swift
//  IDZSwiftModelIO
//
//  Created by Danny Keogan on 5/26/16.
//  Copyright © 2016 iOS Developer Zone. All rights reserved.
//

import ModelIO

// 
// Dump the case statements into text file
// awk 'NF { print "case ."$2": return \""$2"\""; }' MDLVertexFormat.txt > MDLVertexFormat.out.txt
// Copy and paste 
//
extension MDLVertexFormat: CustomDebugStringConvertible {
    public var debugDescription : String {
        switch(self) {
        case .Invalid: return "Invalid"
        case .PackedBit: return "PackedBit"
        case .UCharBits: return "UCharBits"
        case .CharBits: return "CharBits"
        case .UCharNormalizedBits: return "UCharNormalizedBits"
        case .CharNormalizedBits: return "CharNormalizedBits"
        case .UShortBits: return "UShortBits"
        case .ShortBits: return "ShortBits"
        case .UShortNormalizedBits: return "UShortNormalizedBits"
        case .ShortNormalizedBits: return "ShortNormalizedBits"
        case .UIntBits: return "UIntBits"
        case .IntBits: return "IntBits"
        case .HalfBits: return "HalfBits"
        case .FloatBits: return "FloatBits"
        case .UChar: return "UChar"
        case .UChar2: return "UChar2"
        case .UChar3: return "UChar3"
        case .UChar4: return "UChar4"
        case .Char: return "Char"
        case .Char2: return "Char2"
        case .Char3: return "Char3"
        case .Char4: return "Char4"
        case .UCharNormalized: return "UCharNormalized"
        case .UChar2Normalized: return "UChar2Normalized"
        case .UChar3Normalized: return "UChar3Normalized"
        case .UChar4Normalized: return "UChar4Normalized"
        case .CharNormalized: return "CharNormalized"
        case .Char2Normalized: return "Char2Normalized"
        case .Char3Normalized: return "Char3Normalized"
        case .Char4Normalized: return "Char4Normalized"
        case .UShort: return "UShort"
        case .UShort2: return "UShort2"
        case .UShort3: return "UShort3"
        case .UShort4: return "UShort4"
        case .Short: return "Short"
        case .Short2: return "Short2"
        case .Short3: return "Short3"
        case .Short4: return "Short4"
        case .UShortNormalized: return "UShortNormalized"
        case .UShort2Normalized: return "UShort2Normalized"
        case .UShort3Normalized: return "UShort3Normalized"
        case .UShort4Normalized: return "UShort4Normalized"
        case .ShortNormalized: return "ShortNormalized"
        case .Short2Normalized: return "Short2Normalized"
        case .Short3Normalized: return "Short3Normalized"
        case .Short4Normalized: return "Short4Normalized"
        case .UInt: return "UInt"
        case .UInt2: return "UInt2"
        case .UInt3: return "UInt3"
        case .UInt4: return "UInt4"
        case .Int: return "Int"
        case .Int2: return "Int2"
        case .Int3: return "Int3"
        case .Int4: return "Int4"
        case .Half: return "Half"
        case .Half2: return "Half2"
        case .Half3: return "Half3"
        case .Half4: return "Half4"
        case .Float: return "Float"
        case .Float2: return "Float2"
        case .Float3: return "Float3"
        case .Float4: return "Float4"
        case .Int1010102Normalized: return "Int1010102Normalized"
        case .UInt1010102Normalized: return "UInt1010102Normalized"
        }
    }
}

extension MDLVertexAttribute {
    @objc override public var debugDescription : String {
        return "MDLVertexAttribute: { name: \(self.name), format: \(self.format) offset: \(self.offset), bufferIndex: \(self.bufferIndex) }"
    }
}

extension MDLVertexBufferLayout  {
    @objc override public var debugDescription : String {
        return "MDLVertexBufferLayout: { stride: \(self.stride) }"
    }
}

extension MDLVertexAttributeData {
    @objc override public var debugDescription : String {
        return "MDLVertexAttributeData: { dataStart: \(self.dataStart), stride: \(self.stride), format: \(format) }"
    }
    
}

extension MDLMeshBufferType : CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .Vertex: return "Vertex"
        case .Index: return "Index"
        }
    }
}

extension MDLGeometryType: CustomDebugStringConvertible {
    public var debugDescription : String {
        switch self {
        case .TypePoints: return "TypePoints"
        case .TypeLines: return "TypeLines"
        case .TypeQuads: return "TypeQuads"
        case .TypeTriangles: return "TypeTriangles"
        case .TypeTriangleStrips: return "TypeTriangleStrips"
        case .TypeVariableTopology: return "TypeVariableTopology"
        }
    }
}

/**
 Refining MDLVertexDescriptor
 */
extension MDLVertexDescriptor {
    /**
     The existing routine is not type safe and return invalid results.
    */
    var idz_attributes: [MDLVertexAttribute] {
        return self.attributes
            .map { $0 as! MDLVertexAttribute }
            .filter { $0.format.rawValue != 0 }
    }
}


extension MDLMesh {
    public func dumpMaterials() {
        for submesh in (self.submeshes.map { $0 as! MDLSubmesh }) {
            let material = submesh.material!
            for propertyIndex in 0..<material.count {
                if let property = material[propertyIndex] {
                    /* Shouldn't need explicit `.debugDescription` but do because Swift */
                    debugPrint("[\(propertyIndex)]: \(property.debugDescription)")
                }
                else {
                    debugPrint("[\(propertyIndex)]: nil")
                    
                }
            }
            debugPrint("Using material[\"specularExponent\"]=\(material["specularExponent"])")
            debugPrint("Using material.propertyWithSemantic(.SpecularExponent)=\(material.propertyWithSemantic(.SpecularExponent))")
        }
    }
}

extension MDLSubmesh /* : CustomDebugStringConvertible */ {
    override public var debugDescription: String {
        return "MDLSubmesh: { indexBuffer: \(self.indexBuffer), indexCount: \(self.indexCount), indexType:\(self.indexType), geometryType:\(self.geometryType), material:\(self.material) topology:\(self.topology), name: \(self.name) }"
        
    }
}

extension MDLMaterial /* : CustomDebugStringConvertible */ {
    override public var debugDescription: String {
        var properties = [String]()
        for property in self.idz_properties {
            let s = "\(property.detailedDescription)"
            properties.append(s)
        }
        return "MDLMaterial: { name: \(self.name), properties: [ \(properties.joinWithSeparator(", "))] }"
        
    }
}
/**
 Provides useful debugging information about an `MDLMaterialProperty`
 */
extension MDLMaterialProperty {
    /**
     Overrides the default, useless implementation to return information like:
     `MDLMaterialProperty(name:"", semantic:SpecularExponent, type:Float, value:0.0)`
     */
    override public var debugDescription: String {
        return self.detailedDescription
    }
    /**
     A human readible string represeantion of this value for debugging purposes.
     */
    public var detailedDescription: String {
        var value = ""
        switch(type) {
        case .None: value = "None"
        case .String: value = "\(stringValue)"
        case .URL: value = "\(URLValue)"
        case .Texture: value = "\(textureSamplerValue)"
        case .Color: value = "\(color)"
        case .Float: value = "\(floatValue)"
        case .Float2: value = "\(float2Value)"
        case .Float3: value = "\(float3Value)"
        case .Float4: value = "\(float4Value)"
        case .Matrix44: value = "\(matrix4x4)"
        }
        return "MDLMaterialProperty: { name:\"\(self.name)\", semantic:\(self.semantic.debugDescription), type:\(self.type.debugDescription), value:\(value)}"
    }
}
/**
 Provides useful debugging information about an `MDLMaterialPropertyType`
 */
extension MDLMaterialPropertyType: CustomDebugStringConvertible {
    /**
     A human readible string represeantion of this value for debugging purposes.
     */
    public var debugDescription: Swift.String {
        switch self {
        case None: return "None"
        case String: return "String"
        case URL: return "URL"
        case Texture: return "Texture"
        case Color: return "Color"
        case Float: return "Float"
        case Float2: return "Float2"
        case Float3: return "Float3"
        case Float4: return "Float4"
        case Matrix44: return "Matrix44"
        }
    }
}
/**
 Provides useful debugging information about an `MDLMaterialSemantic`
 */
extension MDLMaterialSemantic: CustomDebugStringConvertible {
    /**
     A human readible string represeantion of this value for debugging purposes.
     */
    public var debugDescription: String {
        switch self {
        case BaseColor: return "BaseColor"
        case Subsurface: return "Subsurface"
        case Metallic: return "Metallic"
        case Specular: return "Specular"
        case SpecularExponent: return "SpecularExponent"
        case SpecularTint: return "SpecularTint"
        case Roughness: return "Roughness"
        case Anisotropic: return "Anisotropoc"
        case AnisotropicRotation: return "AnisotropicRotation"
        case Sheen: return "Sheen"
        case SheenTint: return "SheenTint"
        case Clearcoat: return "Clearcoat"
        case ClearcoatGloss: return "ClearcoatGloss"
            
        case Emission: return "Emission"
        case Bump: return "Bump"
        case Opacity: return "Opacity"
        case InterfaceIndexOfRefraction: return "InterfaceIndexOfRefraction"
        case MaterialIndexOfRefraction: return "MaterialIndexOfRefraction"
        case ObjectSpaceNormal: return "ObjectSpaceNormal"
        case TangentSpaceNormal: return "TangentSpaceNormal"
        case Displacement: return "Displacement"
        case DisplacementScale: return "DisplacementScale"
        case AmbientOcclusion: return "AmbientOcclusion"
        case AmbientOcclusionScale: return "AmbientOcclusionScale"
            
        case None: return "None"
        case UserDefined: return "UserDefined"
        }
    }
}


