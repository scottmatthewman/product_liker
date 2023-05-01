import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    create(event) {
        event.preventDefault();

        // Get the CSRF token from the <meta> tag. This isn't provided in testing, so
        // we make getting the content optionally chained with `?.`.
        const csrfToken = document.querySelector("meta[name='csrf-token']")?.content;

        // The event may be received by the button or its child elements (the heart
        // symbol or the likes count), so make sure we look for the article ID on the
        // button itself.
        const button = event.target.closest("button");
        const { articleId } = button.dataset;

        fetch('/likes', {
            method: 'POST',
            mode: 'cors',
            cache: 'no-cache',
            credentials: 'same-origin',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify({ article_id: articleId })
        })
        .then(response => response.json())
        .then(data => {
            const { likes } = data;
            button.querySelector(".likes-count").innerText = likes;
        })
        .catch(error => alert(error));

        event.preventDefault();
    }
}
