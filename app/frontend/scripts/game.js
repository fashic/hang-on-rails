$(document).ready(() => {
  const drawHangman = () => {
    const errorsMade = +$('#errors-made').text()

    for (let count = 1; count < 8; count++) {
      if (errorsMade >= count ) {
        $(`#errors-${count}`).show()
      }
    }
  }

  $('#play-form').on('submit', function(event) {
    $.ajax({
      url: $(this).attr('action'),
      data: $(this).serialize(),
      method: $(this).attr('method'),
      dataType: 'json',
      success: data => {
        $('#current-status').html(data.current)
        $('#letter').val('')
        drawHangman()
      }
    })
    event.preventDefault()
  })

  drawHangman()
})
