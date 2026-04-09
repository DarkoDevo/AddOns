import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load API metadata
const metadataPath = path.join(__dirname, '../../api-metadata/makulu.json');
const metadata = JSON.parse(fs.readFileSync(metadataPath, 'utf-8'));

// Output file
const outputPath = path.join(__dirname, '../MakuluHelper/Data/APIData.lua');

/**
 * Escape string for Lua
 */
function escapeLuaString(str) {
  if (!str) return '""';
  return '"' + str
    .replace(/\\/g, '\\\\')
    .replace(/"/g, '\\"')
    .replace(/\n/g, '\\n')
    .replace(/\r/g, '\\r')
    .replace(/\t/g, '\\t') + '"';
}

/**
 * Convert JavaScript object to Lua table
 */
function toLuaTable(obj, indent = 0) {
  const spaces = '  '.repeat(indent);
  const nextSpaces = '  '.repeat(indent + 1);
  
  if (Array.isArray(obj)) {
    if (obj.length === 0) return '{}';
    
    let lua = '{\n';
    for (let i = 0; i < obj.length; i++) {
      lua += nextSpaces;
      if (typeof obj[i] === 'object') {
        lua += toLuaTable(obj[i], indent + 1);
      } else if (typeof obj[i] === 'string') {
        lua += escapeLuaString(obj[i]);
      } else if (typeof obj[i] === 'boolean') {
        lua += obj[i] ? 'true' : 'false';
      } else {
        lua += obj[i];
      }
      lua += ',\n';
    }
    lua += spaces + '}';
    return lua;
  } else {
    let lua = '{\n';
    for (const [key, value] of Object.entries(obj)) {
      lua += nextSpaces + key + ' = ';
      if (typeof value === 'object' && value !== null) {
        lua += toLuaTable(value, indent + 1);
      } else if (typeof value === 'string') {
        lua += escapeLuaString(value);
      } else if (typeof value === 'boolean') {
        lua += value ? 'true' : 'false';
      } else if (value === null) {
        lua += 'nil';
      } else {
        lua += value;
      }
      lua += ',\n';
    }
    lua += spaces + '}';
    return lua;
  }
}

/**
 * Generate Lua file
 */
function generateLuaFile() {
  console.log('🚀 Generating API data for WoW addon...\n');
  
  let lua = '--[[\n';
  lua += '    Makulu Helper - API Database\n';
  lua += '    Auto-generated from api-metadata/makulu.json\n';
  lua += '    DO NOT EDIT MANUALLY\n';
  lua += ']]\n\n';
  
  lua += 'MakuluHelper_APIData = {\n';
  
  for (const [className, classData] of Object.entries(metadata.classes)) {
    console.log(`📝 Processing ${className} (${classData.methods.length} methods)...`);
    
    lua += `  ${className} = {\n`;
    lua += `    className = ${escapeLuaString(className)},\n`;
    lua += `    description = ${escapeLuaString(classData.description)},\n`;
    lua += `    methods = {\n`;
    
    for (const method of classData.methods) {
      lua += '      {\n';
      lua += `        name = ${escapeLuaString(method.name)},\n`;
      lua += `        signature = ${escapeLuaString(method.signature)},\n`;
      lua += `        description = ${escapeLuaString(method.description)},\n`;
      lua += `        category = ${escapeLuaString(method.category)},\n`;
      
      // Parameters
      if (method.parameters && method.parameters.length > 0) {
        lua += '        parameters = {\n';
        for (const param of method.parameters) {
          lua += '          {\n';
          lua += `            name = ${escapeLuaString(param.name)},\n`;
          lua += `            type = ${escapeLuaString(param.type)},\n`;
          lua += `            description = ${escapeLuaString(param.description)},\n`;
          lua += `            optional = ${param.optional ? 'true' : 'false'},\n`;
          lua += '          },\n';
        }
        lua += '        },\n';
      }
      
      // Returns
      if (method.returns) {
        lua += '        returns = {\n';
        lua += `          type = ${escapeLuaString(method.returns.type)},\n`;
        lua += `          description = ${escapeLuaString(method.returns.description)},\n`;
        lua += '        },\n';
      }
      
      // Example
      if (method.example) {
        lua += `        example = ${escapeLuaString(method.example)},\n`;
      }
      
      lua += '      },\n';
    }
    
    lua += '    },\n';
    lua += '  },\n';
  }
  
  lua += '}\n';
  
  // Write to file
  fs.writeFileSync(outputPath, lua, 'utf-8');
  
  console.log(`\n✅ Generated API data successfully!`);
  console.log(`📁 Output: ${outputPath}`);
  console.log(`📊 Total classes: ${Object.keys(metadata.classes).length}`);
  
  let totalMethods = 0;
  for (const classData of Object.values(metadata.classes)) {
    totalMethods += classData.methods.length;
  }
  console.log(`📊 Total methods: ${totalMethods}`);
}

// Run the generator
generateLuaFile();

