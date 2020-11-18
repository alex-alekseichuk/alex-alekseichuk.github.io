---
layout: post
title: "Code sample in the book"
description: Code samples in the books are not so good, as should be in the books.
summary: Code samples in the books are not so good, as should be in the books.
tags: typescript
---

I read the book called like Modern Development using TypeScript and blah-blah-blah.
Well, you can find a lot of books like that.

I spot an example:

```
getMailboxes().then(function() {
  async function getContacts() {
    const contactsWorker: Contacts.Worker = new Contacts.Worker();
    const contacts: Contacts.IContact[] = await contactsWorker.listContacts();
    contacts.forEach((inContact) => {
      baseComponent.state.addContactToList(inContact);
    });
  }
  getContacts().then(() =>
    baseComponent.state.showHidePleaseWait(false));
});
```

which I would re-write like

```
getMailboxes().then(() => {
  const contactsWorker: Contacts.Worker = new Contacts.Worker();
  return contactsWorker.listContacts();
}).then((contacts: Contacts.IContact[]) => {
  contacts.forEach(inContact =>
    baseComponent.state.addContactToList(inContact));
}).then(() =>
  baseComponent.state.showHidePleaseWait(false));
});
```

or even better

```
await getMailboxes();
const contactsWorker: Contacts.Worker = new Contacts.Worker();
const contacts: Contacts.IContact[] = await contactsWorker.listContacts();
contacts.forEach(inContact =>
  baseComponent.state.addContactToList(inContact));
baseComponent.state.showHidePleaseWait(false));
```

There would be compact, good code instead of something copy-pasted from the project of the author.
Anybody can code something, but it's not so easy to write really good code and good book, as well.

Happy reading!