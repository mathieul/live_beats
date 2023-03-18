defmodule LiveBeats.Audio do
  def speech_to_test(path, fund) do
    {:ok, whisper} = Bumblebee.load_model({:hf, "openai/whisper-tiny"})
    {:ok, featurizer} = Bumblebee.load_featurizer({:hf, "openai/whisper-tiny"})
    {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "openai/whisper-tiny"})

    serving =
      Bumblebee.Audio.speech_to_text(whisper, featurizer, tokenizer,
        max_new_tokens: 100,
        defn_options: [compiler: EXLA]
      )

    Nx.Serving.run(serving, {:file, path})
  end
end
