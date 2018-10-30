<?php

namespace App\Entity;

use Symfony\Component\Validator\Constraints as Assert;
use Doctrine\ORM\Mapping as ORM;
use ApiPlatform\Core\Annotation\ApiResource;

/**
 * Favorite beer.
 *
 * @ORM\Entity
 * @ApiResource
 */
class Favorite
{
    /**
     * @var int The id of this favorite.
     *
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @var string Who likes the beer?
     *
     * @ORM\Column(type="string")
     * @Assert\NotBlank
     */
    public $author;

    /**
     * @var \DateTimeInterface The date of when the beer is added to favorites.
     *
     * @ORM\Column(type="datetime_immutable")
     * @Assert\NotNull
     */
    public $publicationDate;

    /**
     * @var Beer The beer which is added to favorites.
     *
     * @ORM\OneToOne(targetEntity="Beer")
     */
    public $beer;

    public function getId(): ?int
    {
        return $this->id;
    }
}

