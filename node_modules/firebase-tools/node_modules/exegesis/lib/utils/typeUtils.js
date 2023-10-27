"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isReadable = void 0;
function isReadable(obj) {
    return obj && obj.pipe && typeof obj.pipe === 'function';
}
exports.isReadable = isReadable;
//# sourceMappingURL=typeUtils.js.map