import socket from './socket'
const chatRoomTitle = document.getElementById('chat-room-title')

if (chatRoomTitle) {
  const chatRoomName = chatRoomTitle.dataset.chatRoomName
  const channel = socket.channel(`chat_room:${chatRoomName}`, {})
  const messagesContainer = document.querySelector("[data-role='messages']")

  const messageForm = document.getElementById('new-message-form')
  const messageInput = document.getElementById('message')
  messageForm.addEventListener('submit', event => {
    event.preventDefault()
    channel.push('new_message', { body: messageInput.value })
    event.target.reset()
  })
  const addMessage = (author, body) => {
    const messageItem = document.createElement('li')
    messageItem.dataset.role = 'message'
    messageItem.innerText = `${author}: ${body}`
    messagesContainer.appendChild(messageItem)
  }

  channel.on('new_message', payload => {
    addMessage(payload.author, payload.body)
  })

  channel.join()
    .receive('ok', resp => {
      const messages = resp.messages
      messages.map(({ author, body }) => {
        addMessage(author, body)
      })
    })
}
