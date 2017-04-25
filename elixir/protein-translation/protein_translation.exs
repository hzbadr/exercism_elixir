defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    case String.split_at(rna, 3) do
      {"", ""} -> {:ok, []}
      {codon, remaining} ->
        case of_codon(codon) do
          {:error, _} -> {:error, "invalid RNA"}
          {:ok, "STOP"} -> {:ok, []}
          {:ok, protein} ->
            {:ok, proteins} = of_rna(remaining)
            {:ok, [protein | proteins]}
        end
    end
  end

@codes  %{
    :UGU => "Cysteine",
    :UGC => "Cysteine",
    :UUA => "Leucine",
    :UUG => "Leucine",
    :AUG => "Methionine",
    :UUU => "Phenylalanine",
    :UUC => "Phenylalanine",
    :UCU => "Serine",
    :UCC => "Serine",
    :UCA => "Serine",
    :UCG => "Serine",
    :UGG => "Tryptophan",
    :UAU => "Tyrosine",
    :UAC => "Tyrosine",
    :UAA => "STOP",
    :UAG => "STOP",
    :UGA => "STOP"
  }
  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case @codes[String.to_atom(codon)] do
      nil -> {:error, "invalid codon"}
      code -> {:ok, code}
    end
  end
end
