import { withPluginApi } from "discourse/lib/plugin-api";
import ActionToggle from "../components/action-toggle";

export default {
  name: "toggle-actions",
  initialize() {
    withPluginApi("0.11.0", (api) => {
      api.registerValueTransformer(
        "post-menu-buttons",
        ({ value: dag, context: { lastHiddenButtonKey } }) => {
          dag.add("post-folding-action", ActionToggle, {
            before: lastHiddenButtonKey,
          });
        }
      );
    });
  },
};
