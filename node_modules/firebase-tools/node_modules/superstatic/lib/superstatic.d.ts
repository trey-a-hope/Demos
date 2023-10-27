export = superstatic;
/**
 * Superstatic returns a router that can be used in a server.
 * @param {MiddlewareOptions} spec superstatic options.
 * @return {HandleFunction} router handler.
 */
declare function superstatic(spec?: MiddlewareOptions): HandleFunction;
declare namespace superstatic {
    namespace stacks {
        const _default: string[];
        export { _default as default };
        export const strict: string[];
    }
}
import { MiddlewareOptions } from "./options";
import { HandleFunction } from "connect";
