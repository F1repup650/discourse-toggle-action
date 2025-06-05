import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";

export default class PostMenuFoldingButton extends Component {
  static hidden() {
    return true;
  }

  static shouldRender(args) {
    return args.state.currentUser?.staff;
  }

  @service appEvents;

  get isAction() {
    return this.args.post.post_type === 3;
  }

  get title() {
    return themePrefix(
      this.isAction
        ? "toggle_button_title.regular"
        : "toggle_button_title.action"
    );
  }

  get icon() {
    return this.isAction ? "far-bell-slash" : "far-bell";
  }

  @action
  toggleAction() {
    const model = this.args.post;
    let newType = model.post_type === 3 ? 1 : 3;
    ajax(`/posts/${model.id}/post_type`, {
      type: "PUT",
      data: {
        post_type: newType,
      },
    }).catch(popupAjaxError);
  }

  <template>
    <DButton
      class="toggle-action-btn"
      ...attributes
      @action={{this.toggleAction}}
      @icon={{this.icon}}
      @title={{this.title}}
    />
  </template>
}
